#!/usr/bin/env python3
"""
Generate packages/*.nix files from upstream idris2-pack-db HEAD.toml.

Usage:
    nix run nixpkgs#python3 -- scripts/generate-from-head.py <path-to-HEAD.toml>

This script:
1. Parses HEAD.toml from the upstream package database
2. Groups packages by source URL (so async, async-dom, etc. share one source)
3. Generates packages/<group>.nix files
4. Skips deprecated and packagePath=true entries
"""

import sys
import re
from pathlib import Path
from collections import defaultdict


def parse_head_toml(content: str) -> dict:
    """Parse HEAD.toml into a dict of packages."""
    packages = {}
    current_pkg = None
    
    for line in content.split('\n'):
        line = line.strip()
        if not line or line.startswith('#'):
            continue
        
        # Match [db.<name>]
        if match := re.match(r'^\[db\.(.*)\]$', line):
            current_pkg = match.group(1)
            packages[current_pkg] = {}
            continue
        
        if current_pkg is None:
            continue
        
        # Match key = "value"
        if match := re.match(r'^(\w+)\s*=\s*"(.*)"$', line):
            key, value = match.groups()
            packages[current_pkg][key] = value
    
    return packages


def url_to_group_name(url: str) -> str:
    """Convert a URL to a group name for the .nix file."""
    # Extract owner/repo from URL
    if 'github.com' in url:
        parts = url.replace('https://github.com/', '').split('/')
        if len(parts) >= 2:
            repo = parts[1].replace('idris2-', '').replace('idris-', '')
            return repo
    elif 'gitlab.com' in url:
        parts = url.replace('https://gitlab.com/', '').split('/')
        if len(parts) >= 2:
            return parts[-1].replace('idris2-', '').replace('idris-', '')
    elif 'git.sr.ht' in url:
        parts = url.replace('https://git.sr.ht/~', '').split('/')
        if parts:
            return parts[-1]
    elif 'codeberg.org' in url:
        parts = url.replace('https://codeberg.org/', '').split('/')
        if len(parts) >= 2:
            return parts[-1]
    
    # Fallback: use last path component
    return url.split('/')[-1].replace('.git', '')


def generate_fetcher(url: str, commit: str) -> str:
    """Generate the Nix fetcher expression for a URL."""
    if 'github.com' in url:
        owner_repo = url.replace('https://github.com/', '')
        parts = owner_repo.split('/')
        owner = parts[0]
        repo = parts[1] if len(parts) > 1 else ''
        return f'''pkgs.fetchFromGitHub {{
    owner = "{owner}";
    repo = "{repo}";
    rev = "{commit}";
    hash = "sha256-AAAA";  # TODO: run ./scripts/update-hashes.sh
  }}'''
    elif 'gitlab.com' in url:
        owner_repo = url.replace('https://gitlab.com/', '')
        parts = owner_repo.split('/')
        owner = parts[0]
        repo = parts[1] if len(parts) > 1 else ''
        return f'''pkgs.fetchFromGitLab {{
    owner = "{owner}";
    repo = "{repo}";
    rev = "{commit}";
    hash = "sha256-AAAA";  # TODO: run ./scripts/update-hashes.sh
  }}'''
    else:
        # Generic git fetcher
        return f'''builtins.fetchGit {{
    url = "{url}";
    ref = "{commit}";
    allRefs = true;
  }}'''


def generate_package_file(group_name: str, pkgs: list, packages_dir: Path) -> None:
    """Generate a .nix file for a group of packages from the same source."""
    if not pkgs:
        return
    
    first = pkgs[0]
    url = first['url']
    commit = first.get('commit', 'main')
    
    # Handle "latest:" prefix in commit
    if commit.startswith('latest:'):
        commit = commit.replace('latest:', '')
    
    lines = [f"# Auto-generated from idris2-pack-db HEAD.toml"]
    lines.append(f"# Source: {url}")
    lines.append("")
    lines.append("{ pkgs, buildIdrisWithDocs }:")
    lines.append("")
    
    if len(pkgs) == 1:
        # Single package
        pkg = pkgs[0]
        pname = pkg['name']
        ipkg = pkg.get('ipkg', f'{pname}.ipkg')
        notice = pkg.get('notice', '')
        
        if notice:
            lines.append(f"# NOTE: {notice}")
        
        fetcher = generate_fetcher(url, commit)
        lines.append(f'''buildIdrisWithDocs {{
  pname = "{pname}";
  ipkg = "{ipkg}";
  src = {fetcher};
  deps = [ ];  # TODO: Add Idris dependencies
}}''')
    else:
        # Multiple packages from same source
        lines.append("let")
        fetcher = generate_fetcher(url, commit)
        lines.append(f"  src = {fetcher};")
        lines.append("in")
        lines.append("{")
        
        for pkg in pkgs:
            pname = pkg['name']
            ipkg = pkg.get('ipkg', f'{pname}.ipkg')
            notice = pkg.get('notice', '')
            
            if notice:
                lines.append(f"  # NOTE: {notice}")
            
            lines.append(f'''  {pname} = buildIdrisWithDocs {{
    pname = "{pname}";
    ipkg = "{ipkg}";
    inherit src;
    deps = [ ];  # TODO: Add Idris dependencies
  }};''')
        
        lines.append("}")
    
    output = "\n".join(lines) + "\n"
    
    # Write file
    outfile = packages_dir / f"{group_name}.nix"
    outfile.write_text(output)
    print(f"Generated: {outfile}")


def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <path-to-HEAD.toml>")
        print("")
        print("Example:")
        print("  nix run nixpkgs#python3 -- scripts/generate-from-head.py \\")
        print("    /nix/store/...-idris2-pack-db/collections/HEAD.toml")
        sys.exit(1)
    
    head_toml_path = Path(sys.argv[1])
    if not head_toml_path.exists():
        print(f"Error: {head_toml_path} not found")
        sys.exit(1)
    
    # Parse HEAD.toml
    content = head_toml_path.read_text()
    packages = parse_head_toml(content)
    
    # Filter out deprecated and packagePath entries
    active_packages = {}
    for name, pkg in packages.items():
        if pkg.get('packagePath') == 'true':
            print(f"Skipping {name} (packagePath=true)")
            continue
        notice = pkg.get('notice', '')
        if 'DEPRECATED' in notice:
            print(f"Skipping {name} (deprecated)")
            continue
        pkg['name'] = name
        active_packages[name] = pkg
    
    # Group by source URL
    groups = defaultdict(list)
    for name, pkg in active_packages.items():
        url = pkg.get('url', '')
        if not url:
            print(f"Warning: {name} has no URL, skipping")
            continue
        group_name = url_to_group_name(url)
        groups[group_name].append(pkg)
    
    # Create packages directory
    registry_dir = Path(__file__).parent.parent
    packages_dir = registry_dir / "packages"
    packages_dir.mkdir(exist_ok=True)
    
    # Backup existing files
    for f in packages_dir.glob("*.nix"):
        backup = f.with_suffix('.nix.bak')
        f.rename(backup)
        print(f"Backed up: {f} -> {backup}")
    
    # Generate files
    for group_name, pkgs in sorted(groups.items()):
        generate_package_file(group_name, pkgs, packages_dir)
    
    print(f"\nGenerated {len(groups)} package files in {packages_dir}")
    print("Next steps:")
    print("  1. Review generated files")
    print("  2. Add dependencies to deps = [ ] lists")
    print("  3. Run: ./scripts/update-hashes.sh all")
    print("  4. Test: nix flake check --no-build")


if __name__ == '__main__':
    main()
