#!/usr/bin/env python3
"""
Extract dependencies from .ipkg files in fetched package sources.

Usage:
    nix run nixpkgs#python3 -- scripts/extract-deps.py

This script:
1. Reads all packages/*.nix files
2. Fetches each source (using nix-prefetch-url, which returns the unpacked path)
3. Finds the .ipkg file
4. Extracts the `depends =` list
5. Outputs a JSON mapping of package -> dependencies
"""

import json
import os
import re
import subprocess
import sys
from pathlib import Path

REGISTRY_DIR = Path(__file__).parent.parent
PACKAGES_DIR = REGISTRY_DIR / "packages"

def run_nix_prefetch(owner, repo, rev, fetcher="github"):
    """Fetch source and return the unpacked store path."""
    if fetcher == "github":
        url = f"https://github.com/{owner}/{repo}/archive/{rev}.tar.gz"
    elif fetcher == "gitlab":
        url = f"https://gitlab.com/{owner}/{repo}/-/archive/{rev}/{rev}.tar.gz"
    else:
        return None
    
    try:
        result = subprocess.run(
            ["nix-prefetch-url", "--unpack", url, "--print-path"],
            capture_output=True,
            text=True,
            timeout=60
        )
        if result.returncode == 0:
            lines = result.stdout.strip().split("\n")
            if len(lines) >= 2:
                return lines[1]  # Second line is the store path
    except Exception as e:
        print(f"    Error fetching: {e}")
    return None

def parse_ipkg_deps(ipkg_path):
    """Parse depends = line from .ipkg file."""
    content = ipkg_path.read_text()
    
    # Find depends = section (may span multiple lines)
    match = re.search(r'^depends\s*=\s*(.*?)(?=\n\w|\n\s*$|\Z)', content, re.MULTILINE | re.DOTALL)
    if not match:
        return []
    
    deps_text = match.group(1)
    # Split by comma, strip whitespace and version constraints
    deps = []
    for dep in deps_text.split(","):
        dep = dep.strip()
        # Remove version constraints like >= 0.7.0
        dep = re.sub(r'\s*>=.*', '', dep)
        dep = re.sub(r'\s*>.*', '', dep)
        dep = re.sub(r'\s*<=.*', '', dep)
        dep = re.sub(r'\s*<.*', '', dep)
        dep = dep.strip()
        if dep and dep not in ["prelude", "base"]:
            deps.append(dep)
    
    return deps

def extract_package_info(nix_file):
    """Extract fetcher info from a .nix file."""
    content = nix_file.read_text()
    
    info = {
        "pname": None,
        "ipkg": None,
        "fetcher": None,
        "owner": None,
        "repo": None,
        "rev": None,
        "url": None,
    }
    
    # Extract pname
    m = re.search(r'pname\s*=\s*"([^"]+)"', content)
    if m:
        info["pname"] = m.group(1)
    
    # Extract ipkg
    m = re.search(r'ipkg\s*=\s*"([^"]+)"', content)
    if m:
        info["ipkg"] = m.group(1)
    
    # Detect fetcher
    if "fetchFromGitHub" in content:
        info["fetcher"] = "github"
        m = re.search(r'owner\s*=\s*"([^"]+)"', content)
        if m:
            info["owner"] = m.group(1)
        m = re.search(r'repo\s*=\s*"([^"]+)"', content)
        if m:
            info["repo"] = m.group(1)
        m = re.search(r'rev\s*=\s*"([^"]+)"', content)
        if m:
            info["rev"] = m.group(1)
    elif "fetchFromGitLab" in content:
        info["fetcher"] = "gitlab"
        m = re.search(r'owner\s*=\s*"([^"]+)"', content)
        if m:
            info["owner"] = m.group(1)
        m = re.search(r'repo\s*=\s*"([^"]+)"', content)
        if m:
            info["repo"] = m.group(1)
        m = re.search(r'rev\s*=\s*"([^"]+)"', content)
        if m:
            info["rev"] = m.group(1)
    elif "builtins.fetchGit" in content:
        info["fetcher"] = "git"
        m = re.search(r'url\s*=\s*"([^"]+)"', content)
        if m:
            info["url"] = m.group(1)
            # Extract ref if available
            m2 = re.search(r'ref\s*=\s*"([^"]+)"', content)
            if m2:
                info["rev"] = m2.group(1)
    
    return info

def main():
    deps_map = {}
    errors = []
    
    nix_files = sorted(PACKAGES_DIR.glob("*.nix"))
    print(f"Scanning {len(nix_files)} packages...")
    
    for nix_file in nix_files:
        pkg_name = nix_file.stem
        info = extract_package_info(nix_file)
        
        if not info["pname"]:
            print(f"⚠ {pkg_name}: Could not extract pname, skipping")
            continue
        
        print(f"\n{pkg_name} ({info['pname']}):")
        
        # Fetch source
        store_path = None
        if info["fetcher"] in ("github", "gitlab") and info["owner"] and info["repo"] and info["rev"]:
            store_path = run_nix_prefetch(info["owner"], info["repo"], info["rev"], info["fetcher"])
        elif info["fetcher"] == "git" and info["url"] and info["rev"]:
            # For builtins.fetchGit, we can't easily prefetch
            print(f"  ℹ builtins.fetchGit, skipping")
            continue
        
        if not store_path:
            print(f"  ✗ Failed to fetch source")
            errors.append((pkg_name, "fetch failed"))
            continue
        
        # Find .ipkg file
        ipkg_name = info["ipkg"] or f"{info['pname']}.ipkg"
        ipkg_path = Path(store_path) / ipkg_name
        
        if not ipkg_path.exists():
            # Try without subdirectory
            ipkg_path = Path(store_path) / Path(ipkg_name).name
        
        if not ipkg_path.exists():
            print(f"  ✗ .ipkg not found: {ipkg_name}")
            errors.append((pkg_name, f"ipkg not found: {ipkg_name}"))
            continue
        
        # Parse dependencies
        deps = parse_ipkg_deps(ipkg_path)
        deps_map[info["pname"]] = deps
        print(f"  ✓ deps: {deps}")
    
    # Write output
    output_file = REGISTRY_DIR / "deps-extracted.json"
    with open(output_file, "w") as f:
        json.dump(deps_map, f, indent=2, sort_keys=True)
    
    print(f"\n{'='*60}")
    print(f"Wrote {len(deps_map)} packages to {output_file}")
    print(f"Errors: {len(errors)}")
    for pkg, err in errors:
        print(f"  - {pkg}: {err}")
    
    # Print summary of all unique dependencies
    all_deps = set()
    for deps in deps_map.values():
        all_deps.update(deps)
    
    print(f"\nUnique dependencies ({len(all_deps)}):")
    for dep in sorted(all_deps):
        print(f"  - {dep}")

if __name__ == "__main__":
    main()
