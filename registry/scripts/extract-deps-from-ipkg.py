#!/usr/bin/env python3
"""
Extract dependencies from .ipkg files and update packages/*.nix.

Parses HEAD.toml directly to get package info, avoiding nix evaluation.
Handles both single-package and multi-package .nix files.

Usage:
    ./scripts/extract-deps-from-ipkg.py [path-to-HEAD.toml]

If HEAD.toml path not given, tries to find it from the flake's idris2-pack-db input.
"""

import json
import os
import re
import subprocess
import sys
from pathlib import Path

REGISTRY_DIR = Path(__file__).parent.parent
PACKAGES_DIR = REGISTRY_DIR / "packages"
FLAKE_ROOT = REGISTRY_DIR.parent

BUILTINS = {"prelude", "base", "contrib", "linear", "network", "test"}


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


def run_nix_eval(expr: str) -> str:
    """Run nix eval and return stdout."""
    result = subprocess.run(
        ["nix", "eval", "--impure", "--expr", expr, "--raw"],
        capture_output=True,
        text=True,
    )
    if result.returncode != 0:
        raise RuntimeError(result.stderr.strip())
    return result.stdout.strip()


def get_head_toml_path() -> Path:
    """Get HEAD.toml path from flake's idris2-pack-db input."""
    expr = '''
      let flake = builtins.getFlake "path:''' + str(FLAKE_ROOT) + '''";
      in "${flake.inputs.idris2-pack-db}/collections/HEAD.toml"
    '''
    return Path(run_nix_eval(expr))


def fetch_source(url: str, commit: str) -> Path:
    """Fetch source and return store path."""
    # Determine fetcher type from URL
    if 'github.com' in url:
        parts = url.replace('https://github.com/', '').split('/')
        owner, repo = parts[0], parts[1]
        tarball_url = f"https://github.com/{owner}/{repo}/archive/{commit}.tar.gz"
        result = subprocess.run(
            ["nix-prefetch-url", "--unpack", tarball_url, "--print-path"],
            capture_output=True, text=True, timeout=120
        )
        if result.returncode == 0:
            lines = result.stdout.strip().split('\n')
            if len(lines) >= 2:
                return Path(lines[1])
    elif 'gitlab.com' in url:
        parts = url.replace('https://gitlab.com/', '').split('/')
        owner, repo = parts[0], parts[1]
        tarball_url = f"https://gitlab.com/{owner}/{repo}/-/archive/{commit}/{commit}.tar.gz"
        result = subprocess.run(
            ["nix-prefetch-url", "--unpack", tarball_url, "--print-path"],
            capture_output=True, text=True, timeout=120
        )
        if result.returncode == 0:
            lines = result.stdout.strip().split('\n')
            if len(lines) >= 2:
                return Path(lines[1])
    else:
        # Generic git - use nix eval with builtins.fetchGit
        expr = f'''
          (builtins.fetchGit {{
            url = "{url}";
            ref = "{commit}";
            allRefs = true;
          }}).outPath
        '''
        return Path(run_nix_eval(expr))
    
    raise RuntimeError(f"Failed to fetch {url}@{commit}")


def extract_ipkg_deps(ipkg_path: Path) -> list[str]:
    """Parse depends = from an .ipkg file."""
    content = ipkg_path.read_text()

    match = re.search(r'^depends\s*=\s*(.*?)(?=\n\w|\n\s*$|\Z)', content, re.MULTILINE | re.DOTALL)
    if not match:
        return []

    deps_text = match.group(1)
    deps = []
    for dep in deps_text.split(','):
        dep = dep.strip()
        dep = re.sub(r'\s*>=.*', '', dep)
        dep = re.sub(r'\s*>.*', '', dep)
        dep = re.sub(r'\s*<=.*', '', dep)
        dep = re.sub(r'\s*<.*', '', dep)
        dep = dep.strip()
        if dep and dep not in BUILTINS:
            deps.append(dep)

    return sorted(set(deps))


def extract_packages_from_nix(nix_file: Path) -> list[dict]:
    """Extract all (pname, ipkg) pairs from a .nix file."""
    content = nix_file.read_text()
    lines = content.split('\n')
    packages = []

    i = 0
    while i < len(lines):
        line = lines[i]
        pname_match = re.search(r'pname\s*=\s*"([^"]+)"', line)
        if pname_match:
            pname = pname_match.group(1)
            ipkg = None
            for j in range(i, min(i + 5, len(lines))):
                ipkg_match = re.search(r'ipkg\s*=\s*"([^"]+)"', lines[j])
                if ipkg_match:
                    ipkg = ipkg_match.group(1)
                    break
            if ipkg:
                packages.append({"pname": pname, "ipkg": ipkg})
        i += 1

    return packages


def update_deps_for_pname(nix_file: Path, pname: str, deps: list[str]) -> bool:
    """Update deps for a specific pname in a .nix file."""
    content = nix_file.read_text()
    lines = content.split('\n')

    # Find the line with our pname
    pname_line_idx = None
    for i, line in enumerate(lines):
        if f'pname = "{pname}"' in line:
            pname_line_idx = i
            break

    if pname_line_idx is None:
        return False

    # Find the deps block start and end
    deps_start_idx = None
    deps_end_idx = None
    for i in range(pname_line_idx + 1, len(lines)):
        line = lines[i]
        # Stop if we hit another pname or a closing brace at low indentation
        if re.search(r'^\s*\}\s*$', line) or re.search(r'pname\s*=', line):
            break
        if re.search(r'^\s*deps\s*=\s*\[', line):
            deps_start_idx = i
            # Find the closing ];
            for j in range(i, len(lines)):
                if re.search(r'\]\s*;\s*$', lines[j]):
                    deps_end_idx = j
                    break
            break

    if deps_start_idx is None:
        return False

    if deps_end_idx is None:
        deps_end_idx = deps_start_idx

    if deps:
        deps_str = "[ " + " ".join(f'"{d}"' for d in deps) + " ]"
    else:
        deps_str = "[ ]"

    # Get indentation from the original deps line
    old_line = lines[deps_start_idx]
    indent = re.match(r'^(\s*)', old_line).group(1)

    # Replace the entire deps block with a single line
    new_lines = lines[:deps_start_idx]
    new_lines.append(f"{indent}deps = {deps_str};")
    new_lines.extend(lines[deps_end_idx + 1:])

    nix_file.write_text('\n'.join(new_lines))
    return True


def main():
    # Get HEAD.toml path
    if len(sys.argv) >= 2:
        head_toml_path = Path(sys.argv[1])
    else:
        head_toml_path = get_head_toml_path()
    
    if not head_toml_path.exists():
        print(f"Error: HEAD.toml not found at {head_toml_path}")
        sys.exit(1)
    
    print(f"Using HEAD.toml: {head_toml_path}\n")
    
    # Parse HEAD.toml
    head_packages = parse_head_toml(head_toml_path.read_text())
    
    # Group packages by source URL (to avoid fetching same source multiple times)
    sources = {}  # url -> {commit, pkgs: [(name, ipkg)]}
    for name, pkg in head_packages.items():
        url = pkg.get('url', '')
        commit = pkg.get('commit', 'main')
        ipkg = pkg.get('ipkg', f'{name}.ipkg')
        
        # Handle "latest:" prefix
        if commit.startswith('latest:'):
            commit = commit.replace('latest:', '')
        
        if url not in sources:
            sources[url] = {"commit": commit, "pkgs": []}
        sources[url]["pkgs"].append((name, ipkg))
    
    # Build a mapping from pname -> deps
    pname_to_deps = {}
    
    for url, info in sources.items():
        print(f"Fetching {url}@{info['commit']}...")
        try:
            src_path = fetch_source(url, info['commit'])
        except Exception as e:
            print(f"  ✗ Failed: {e}")
            continue
        
        for name, ipkg in info['pkgs']:
            ipkg_path = src_path / ipkg
            if not ipkg_path.exists():
                ipkg_path = src_path / Path(ipkg).name
            
            if not ipkg_path.exists():
                print(f"  ✗ {name}: .ipkg not found: {ipkg}")
                continue
            
            deps = extract_ipkg_deps(ipkg_path)
            pname_to_deps[name] = deps
            
            if deps:
                print(f"  ✓ {name}: deps = {deps}")
            else:
                print(f"  ✓ {name}: no deps")
    
    print(f"\n{'='*60}")
    print(f"Extracted deps for {len(pname_to_deps)} packages from HEAD.toml")
    
    # Now update .nix files
    print(f"\nUpdating packages/*.nix files...\n")
    
    nix_files = sorted(PACKAGES_DIR.glob("*.nix"))
    total_success = 0
    total_failed = 0
    total_skipped = 0
    
    for nix_file in nix_files:
        file_name = nix_file.stem
        packages = extract_packages_from_nix(nix_file)
        
        if not packages:
            continue
        
        for pkg in packages:
            pname = pkg["pname"]
            
            if pname not in pname_to_deps:
                # Package not in HEAD.toml (might be manually added)
                total_skipped += 1
                continue
            
            deps = pname_to_deps[pname]
            
            if update_deps_for_pname(nix_file, pname, deps):
                total_success += 1
            else:
                print(f"✗ {pname}: Could not update deps in {file_name}.nix")
                total_failed += 1
    
    print(f"\n{'='*60}")
    print(f"Done: {total_success} updated, {total_failed} failed, {total_skipped} skipped (not in HEAD.toml)")


if __name__ == "__main__":
    main()
