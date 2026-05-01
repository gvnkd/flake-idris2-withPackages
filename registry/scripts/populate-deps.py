#!/usr/bin/env python3
"""
Populate deps = [ ] for all packages in the registry based on extracted .ipkg dependencies.

Usage:
    nix run nixpkgs#python3 -- scripts/populate-deps.py
"""

import json
import re
from pathlib import Path

REGISTRY_DIR = Path(__file__).parent.parent
PACKAGES_DIR = REGISTRY_DIR / "packages"
DEPS_FILE = REGISTRY_DIR / "deps-extracted.json"

BUILT_IN = {"prelude", "base", "contrib", "linear", "network", "test", "idris2"}

KNOWN_MISSING = {
    "rio": "Deprecated, not in registry",
}

def format_deps(deps, indent="  "):
    valid = []
    comments = []
    
    for dep in deps:
        if dep in BUILT_IN:
            continue
        if dep in KNOWN_MISSING:
            comments.append(f"{indent}  # {dep} ({KNOWN_MISSING[dep]})")
        else:
            valid.append(f'{indent}  "{dep}"')
    
    if not valid and not comments:
        return f"{indent}deps = [ ];"
    
    lines = [f"{indent}deps = ["]
    lines.extend(valid)
    lines.extend(comments)
    lines.append(f"{indent}];")
    
    return chr(10).join(lines)

def update_file(nix_file, pname_to_deps):
    content = nix_file.read_text()
    original = content
    
    # Find all pnames and their positions
    pnames = []
    for m in re.finditer(r'pname\s*=\s*"([^"]+)"', content):
        pnames.append((m.start(), m.group(1)))
    
    if not pnames:
        return False
    
    for i, (pos, pname) in enumerate(pnames):
        if pname not in pname_to_deps:
            continue
        
        deps = pname_to_deps[pname]
        
        # Find the section from this pname to the next pname (or end of file)
        end_pos = pnames[i + 1][0] if i + 1 < len(pnames) else len(content)
        section = content[pos:end_pos]
        
        # Find the deps = [ ] line in this section and get its indentation
        match = re.search(r'(\n)(\s*)deps = \[ \];[^\n]*', section)
        if not match:
            continue
        
        indent = match.group(2)
        new_deps = format_deps(deps, indent)
        
        # Replace only in this section
        new_section = section[:match.start()] + match.group(1) + new_deps + section[match.end():]
        content = content[:pos] + new_section + content[end_pos:]
    
    if content != original:
        nix_file.write_text(content)
        return True
    return False

def main():
    with open(DEPS_FILE) as f:
        deps_data = json.load(f)
    
    updated = 0
    skipped = 0
    no_data = 0
    
    for nix_file in sorted(PACKAGES_DIR.glob("*.nix")):
        pkg_name = nix_file.stem
        content = nix_file.read_text()
        pnames_in_file = re.findall(r'pname\s*=\s*"([^"]+)"', content)
        
        pname_to_deps = {}
        for pname in pnames_in_file:
            if pname in deps_data:
                pname_to_deps[pname] = deps_data[pname]
        
        if not pname_to_deps:
            no_data += 1
            continue
        
        if update_file(nix_file, pname_to_deps):
            print(f"{pkg_name}: updated")
            updated += 1
        else:
            print(f"{pkg_name}: no changes")
            skipped += 1
    
    print(f"\nUpdated: {updated}, Skipped: {skipped}, No data: {no_data}")

if __name__ == "__main__":
    main()
