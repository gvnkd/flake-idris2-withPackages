#!/usr/bin/env bash
# Update source hashes for all packages in the registry
# Usage: ./scripts/update-hashes.sh [package-name]

set -euo pipefail

REGISTRY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PACKAGES_DIR="${REGISTRY_DIR}/packages"

update_hash() {
    local file="$1"
    local pkg_name
    pkg_name=$(basename "$file" .nix)
    
    echo "Processing: $pkg_name"
    
    # Extract URL and type from the package file
    local url
    url=$(grep -oP 'url = "\K[^"]+' "$file" | head -1)
    
    if [ -z "$url" ]; then
        echo "  ⚠ No URL found, skipping"
        return 0
    fi
    
    # Determine fetcher type and compute hash
    local new_hash
    
    if [[ "$url" == *github.com* ]]; then
        local owner repo rev
        owner=$(echo "$url" | sed -n 's|.*/\([^/]*\)/\([^/]*\)$|\1|p')
        repo=$(echo "$url" | sed -n 's|.*/\([^/]*\)/\([^/]*\)$|\2|p')
        rev=$(grep -oP 'rev = "\K[^"]+' "$file" | head -1)
        
        echo "  Fetching: github:$owner/$repo@$rev"
        new_hash=$(nix-prefetch-from-github --owner "$owner" --repo "$repo" --rev "$rev" 2>/dev/null || \
                   nix-prefetch-url --unpack "https://github.com/$owner/$repo/archive/$rev.tar.gz" 2>/dev/null || \
                   echo "")
    elif [[ "$url" == *gitlab.com* ]]; then
        local path rev
        path=$(echo "$url" | sed 's|https://gitlab.com/||')
        rev=$(grep -oP 'rev = "\K[^"]+' "$file" | head -1)
        
        echo "  Fetching: gitlab:$path@$rev"
        new_hash=$(nix-prefetch-git --url "https://gitlab.com/$path" --rev "$rev" 2>/dev/null | grep -oP '"hash": "\K[^"]+' || \
                   nix-prefetch-url --unpack "https://gitlab.com/$path/-/archive/$rev/$rev.tar.gz" 2>/dev/null || \
                   echo "")
    elif [[ "$url" == *git.sr.ht* ]]; then
        local rev
        rev=$(grep -oP 'rev = "\K[^"]+' "$file" | head -1)
        
        echo "  Fetching: $url@$rev"
        new_hash=$(nix-prefetch-git --url "$url" --rev "$rev" 2>/dev/null | grep -oP '"hash": "\K[^"]+' || \
                   nix-prefetch-url --unpack "$url/archive/$rev.tar.gz" 2>/dev/null || \
                   echo "")
    else
        echo "  ⚠ Unknown URL type: $url"
        return 0
    fi
    
    if [ -z "$new_hash" ]; then
        echo "  ✗ Failed to fetch hash"
        return 1
    fi
    
    # Convert to SRI format if needed
    if [[ ! "$new_hash" == sha256-* ]]; then
        new_hash=$(nix hash to-sri --type sha256 "$new_hash" 2>/dev/null || echo "$new_hash")
    fi
    
    # Update the hash in the file
    sed -i "s|hash = \"sha256-AAAA.*\"|hash = \"$new_hash\"|; s|hash = \"sha256-AAAA\"|hash = \"$new_hash\"|" "$file"
    
    echo "  ✓ Updated hash: $new_hash"
}

# Main
case "${1:-}" in
    "")
        echo "Usage: $0 [package-name|all]"
        echo ""
        echo "Update source hashes for packages"
        echo ""
        echo "Examples:"
        echo "  $0 algdata     # Update single package"
        echo "  $0 all         # Update all packages"
        exit 1
        ;;
    all)
        echo "=== Updating all package hashes ==="
        for file in "${PACKAGES_DIR}"/*.nix; do
            if [ -f "$file" ]; then
                update_hash "$file" || true
            fi
        done
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
