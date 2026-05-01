#!/usr/bin/env bash
# Update source hashes for all packages in the registry
# Usage: ./scripts/update-hashes.sh [package-name|all]
# Packages with valid hashes are skipped if updated within the last 2 hours (TTL=7200s)

set -euo pipefail

REGISTRY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGES_DIR="${REGISTRY_DIR}/packages"
TTL_SECONDS=7200  # 2 hours

update_hash() {
    local file="$1"
    local pkg_name
    pkg_name=$(basename "$file" .nix)
    
    echo "Processing: $pkg_name"
    
    # Check if it's builtins.fetchGit (no hash needed)
    if grep -q 'builtins.fetchGit' "$file"; then
        echo "  ℹ builtins.fetchGit (no hash needed), skipping"
        return 0
    fi
    
    # Check if hash is already valid (not AAAA placeholder)
    local current_hash
    current_hash=$(sed -n 's/.*hash = "\([^"]*\)".*/\1/p' "$file" | head -1)
    
    if [ -n "$current_hash" ] && [[ "$current_hash" != *"AAAA"* ]]; then
        # Hash looks valid, check TTL
        local last_update
        last_update=$(sed -n 's/.*# hash-updated: \([0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\} [0-9]\{2\}:[0-9]\{2\}:[0-9]\{2\}\).*/\1/p' "$file" | head -1)
        
        if [ -n "$last_update" ]; then
            local last_epoch now_epoch diff
            last_epoch=$(date -d "$last_update" +%s 2>/dev/null || echo 0)
            now_epoch=$(date +%s)
            diff=$((now_epoch - last_epoch))
            
            if [ "$diff" -lt "$TTL_SECONDS" ]; then
                local mins=$((diff / 60))
                echo "  ℹ Hash valid, updated recently (${mins}m ago), skipping"
                return 0
            fi
        fi
    fi
    
    # Check if it's fetchFromGitHub
    if grep -q 'fetchFromGitHub' "$file"; then
        local owner repo rev
        owner=$(sed -n 's/.*owner = "\([^"]*\)".*/\1/p' "$file" | head -1)
        repo=$(sed -n 's/.*repo = "\([^"]*\)".*/\1/p' "$file" | head -1)
        rev=$(sed -n 's/.*rev = "\([^"]*\)".*/\1/p' "$file" | head -1)
        
        if [ -z "$owner" ] || [ -z "$repo" ] || [ -z "$rev" ]; then
            echo "  ⚠ Missing owner/repo/rev in fetchFromGitHub, skipping"
            return 0
        fi
        
        echo "  Fetching: github:$owner/$repo@$rev"
        local new_hash
        new_hash=$(nix-prefetch-url --unpack "https://github.com/$owner/$repo/archive/$rev.tar.gz" 2>/dev/null || echo "")
        
        if [ -z "$new_hash" ]; then
            echo "  ✗ Failed to fetch hash"
            return 1
        fi
        
        # Convert to SRI format
        new_hash=$(nix hash to-sri --type sha256 "$new_hash" 2>/dev/null || echo "$new_hash")
        
        local timestamp
        timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        sed -i "s|^\(\s*\)hash = \"[^\"]*\".*|\1hash = \"$new_hash\";  # hash-updated: $timestamp|" "$file"
        echo "  ✓ Updated hash: $new_hash"
        return 0
    fi
    
    # Check if it's fetchFromGitLab
    if grep -q 'fetchFromGitLab' "$file"; then
        local owner repo rev
        owner=$(sed -n 's/.*owner = "\([^"]*\)".*/\1/p' "$file" | head -1)
        repo=$(sed -n 's/.*repo = "\([^"]*\)".*/\1/p' "$file" | head -1)
        rev=$(sed -n 's/.*rev = "\([^"]*\)".*/\1/p' "$file" | head -1)
        
        if [ -z "$owner" ] || [ -z "$repo" ] || [ -z "$rev" ]; then
            echo "  ⚠ Missing owner/repo/rev in fetchFromGitLab, skipping"
            return 0
        fi
        
        echo "  Fetching: gitlab:$owner/$repo@$rev"
        local new_hash
        new_hash=$(nix-prefetch-url --unpack "https://gitlab.com/$owner/$repo/-/archive/$rev/$rev.tar.gz" 2>/dev/null || echo "")
        
        if [ -z "$new_hash" ]; then
            echo "  ✗ Failed to fetch hash"
            return 1
        fi
        
        new_hash=$(nix hash to-sri --type sha256 "$new_hash" 2>/dev/null || echo "$new_hash")
        
        local timestamp
        timestamp=$(date '+%Y-%m-%d %H:%M:%S')
        sed -i "s|^\(\s*\)hash = \"[^\"]*\".*|\1hash = \"$new_hash\";  # hash-updated: $timestamp|" "$file"
        echo "  ✓ Updated hash: $new_hash"
        return 0
    fi
    
    # Fallback: look for url = with other fetchers
    local url
    url=$(sed -n 's/.*url = "\([^"]*\)".*/\1/p' "$file" | head -1)
    
    if [ -n "$url" ]; then
        echo "  ⚠ Unknown fetcher with url: $url, skipping"
    else
        echo "  ⚠ No recognized fetcher found, skipping"
    fi
    
    return 0
}

# Main
case "${1:-}" in
    "")
        echo "Usage: $0 [package-name|all]"
        echo ""
        echo "Update source hashes for packages"
        echo ""
        echo "Packages with valid hashes are skipped if updated within ${TTL_SECONDS}s (2 hours)"
        echo ""
        echo "Examples:"
        echo "  $0 async      # Update single package"
        echo "  $0 all        # Update all packages"
        exit 1
        ;;
    all)
        echo "=== Updating all package hashes ==="
        echo "TTL: ${TTL_SECONDS}s (2 hours) — recently updated packages will be skipped"
        echo ""
        for file in "${PACKAGES_DIR}"/*.nix; do
            if [ -f "$file" ]; then
                update_hash "$file" || true
            fi
        done
        echo ""
        echo "=== Done ==="
        ;;
    *)
        file="${PACKAGES_DIR}/${1}.nix"
        if [ ! -f "$file" ]; then
            echo "Error: Package '$1' not found at $file"
            exit 1
        fi
        update_hash "$file"
        ;;
esac
