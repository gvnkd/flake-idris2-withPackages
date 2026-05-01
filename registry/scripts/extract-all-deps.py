#!/usr/bin/env python3
"""
Extract dependencies from .ipkg files, including sub-packages in multi-package repos.

Usage:
    nix run nixpkgs#python3 -- scripts/extract-all-deps.py
"""

import json
import os
import re
import subprocess
from pathlib import Path

REGISTRY_DIR = Path(__file__).parent.parent
PACKAGES_DIR = REGISTRY_DIR / "packages"

def run_nix_prefetch(owner, repo, rev, fetcher="github"):
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
                return lines[1]
    except Exception as e:
        print(f"    Error fetching: {e}")
    return None

def parse_ipkg_deps(ipkg_path):
    if not ipkg_path.exists():
        return None
    
    content = ipkg_path.read_text()
    match = re.search(r'^depends\s*=\s*(.*?)(?=\n\w|\n\s*$|\Z)', content, re.MULTILINE | re.DOTALL)
    if not match:
        return []
    
    deps_text = match.group(1)
    deps = []
    for dep in deps_text.split(","):
        dep = dep.strip()
        dep = re.sub(r'\s*>=.*', '', dep)
        dep = re.sub(r'\s*>.*', '', dep)
        dep = re.sub(r'\s*<=.*', '', dep)
        dep = re.sub(r'\s*<.*', '', dep)
        dep = dep.strip()
        if dep and dep not in ["prelude", "base"]:
            deps.append(dep)
    
    return deps

def extract_package_info(nix_file):
    content = nix_file.read_text()
    
    info = {
        "fetcher": None,
        "owner": None,
        "repo": None,
        "rev": None,
        "url": None,
    }
    
    if "fetchFromGitHub" in content:
        info["fetcher"] = "github"
        m = re.search(r'owner\s*=\s*"([^"]+)"', content)
        if m: info["owner"] = m.group(1)
        m = re.search(r'repo\s*=\s*"([^"]+)"', content)
        if m: info["repo"] = m.group(1)
        m = re.search(r'rev\s*=\s*"([^"]+)"', content)
        if m: info["rev"] = m.group(1)
    elif "fetchFromGitLab" in content:
        info["fetcher"] = "gitlab"
        m = re.search(r'owner\s*=\s*"([^"]+)"', content)
        if m: info["owner"] = m.group(1)
        m = re.search(r'repo\s*=\s*"([^"]+)"', content)
        if m: info["repo"] = m.group(1)
        m = re.search(r'rev\s*=\s*"([^"]+)"', content)
        if m: info["rev"] = m.group(1)
    elif "builtins.fetchGit" in content:
        info["fetcher"] = "git"
        m = re.search(r'url\s*=\s*"([^"]+)"', content)
        if m:
            info["url"] = m.group(1)
            m2 = re.search(r'ref\s*=\s*"([^"]+)"', content)
            if m2: info["rev"] = m2.group(1)
    
    return info

def main():
    deps_map = {}
    errors = []
    
    nix_files = sorted(PACKAGES_DIR.glob("*.nix"))
    print(f"Scanning {len(nix_files)} packages...")
    
    for nix_file in nix_files:
        pkg_name = nix_file.stem
        content = nix_file.read_text()
        
        # Extract all pnames and ipkg paths from this file
        pnames = []
        for m in re.finditer(r'pname\s*=\s*"([^"]+)"', content):
            pnames.append(m.group(1))
        
        ipkgs = []
        for m in re.finditer(r'ipkg\s*=\s*"([^"]+)"', content):
            ipkgs.append(m.group(1))
        
        if not pnames:
            continue
        
        print(f"\n{pkg_name}: {len(pnames)} package(s)")
        
        # Fetch source once per file
        info = extract_package_info(nix_file)
        store_path = None
        
        if info["fetcher"] in ("github", "gitlab") and info["owner"] and info["repo"] and info["rev"]:
            store_path = run_nix_prefetch(info["owner"], info["repo"], info["rev"], info["fetcher"])
        elif info["fetcher"] == "git":
            print(f"  ℹ builtins.fetchGit, skipping")
            continue
        
        if not store_path:
            print(f"  ✗ Failed to fetch source")
            errors.append((pkg_name, "fetch failed"))
            continue
        
        # Parse each .ipkg
        for i, pname in enumerate(pnames):
            ipkg = ipkgs[i] if i < len(ipkgs) else f"{pname}.ipkg"
            ipkg_path = Path(store_path) / ipkg
            
            if not ipkg_path.exists():
                ipkg_path = Path(store_path) / Path(ipkg).name
            
            if not ipkg_path.exists():
                print(f"  ✗ {pname}: .ipkg not found: {ipkg}")
                errors.append((pname, f"ipkg not found: {ipkg}"))
                continue
            
            deps = parse_ipkg_deps(ipkg_path)
            if deps is not None:
                deps_map[pname] = deps
                print(f"  ✓ {pname}: {deps}")
    
    # Write output
    output_file = REGISTRY_DIR / "deps-extracted.json"
    with open(output_file, "w") as f:
        json.dump(deps_map, f, indent=2, sort_keys=True)
    
    print(f"\n{'='*60}")
    print(f"Wrote {len(deps_map)} packages to {output_file}")
    print(f"Errors: {len(errors)}")
    
    all_deps = set()
    for deps in deps_map.values():
        all_deps.update(deps)
    
    print(f"\nUnique dependencies ({len(all_deps)}):")
    for dep in sorted(all_deps):
        print(f"  - {dep}")

if __name__ == "__main__":
    main()
