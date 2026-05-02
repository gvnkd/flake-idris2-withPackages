#!/usr/bin/env bash
# Pin revs for all packages using builtins.fetchGit so they work in pure mode

set -euo pipefail

PACKAGES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../packages" && pwd)"

for file in "${PACKAGES_DIR}"/*.nix; do
    if grep -q 'builtins.fetchGit' "$file"; then
        pkg_name=$(basename "$file" .nix)
        
        # Extract URL from the file
        url=$(grep -oP 'url = "\K[^"]+' "$file" | head -1)
        ref=$(grep -oP 'ref = "\K[^"]+' "$file" | head -1 || echo "master")
        
        if [ -z "$url" ]; then
            echo "Skipping $pkg_name: could not extract URL"
            continue
        fi
        
        echo -n "Pinning rev for $pkg_name ($url)... "
        
        # Get current rev
        rev=$(nix eval --impure --expr "(builtins.fetchGit { url = \"$url\"; ref = \"$ref\"; }).rev" 2>/dev/null || echo "")
        
        if [ -z "$rev" ]; then
            echo "FAILED - could not fetch"
            continue
        fi
        
        echo "got $rev"
        
        # Update the file to add rev after ref
        if ! grep -q 'rev = ' "$file"; then
            # Add rev line after ref line
            sed -i "/ref = \"$ref\";/a\\    rev = \"$rev\";" "$file"
        fi
    fi
done

echo "=== Done ==="
