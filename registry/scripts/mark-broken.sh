#!/usr/bin/env bash
# Mark packages as broken only if they actually fail to evaluate or fetch.
# This script tests each package and marks it broken only if evaluation fails.

set -euo pipefail

PACKAGES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../packages" && pwd)"
FLAKE_ROOT="$(cd "${PACKAGES_DIR}/../.." && pwd)"

# First, remove all existing broken marks so we can retest
for file in "${PACKAGES_DIR}"/*.nix; do
    if grep -q 'meta.broken = true;' "$file"; then
        pkg_name=$(basename "$file" .nix)
        echo "Clearing old broken mark: $pkg_name"
        sed -i '/meta.broken = true;/d' "$file"
    fi
done

# Test all packages
echo ""
echo "Testing all packages for eval/broken status..."
for file in "${PACKAGES_DIR}"/*.nix; do
    pkg_name=$(basename "$file" .nix)
    
    # Skip if already marked broken (shouldn't happen after clearing)
    if grep -q 'meta.broken = true;' "$file"; then
        continue
    fi
    
    echo -n "Testing $pkg_name... "
    
    # Try to evaluate the package
    if nix eval --impure --expr "
      let
        flake = builtins.getFlake \"path:${FLAKE_ROOT}\";
        pkg = flake.packages.\${builtins.currentSystem}.${pkg_name} or null;
      in
        if pkg == null then \"not-found\" else pkg.outPath
    " 2>/dev/null >/dev/null; then
        echo "OK"
    else
        echo "FAILED - marking as broken"
        
        # Add meta.broken = true before the last closing brace
        awk '
        /^}$/ { last_brace = NR }
        { lines[NR] = $0 }
        END {
            for (i = 1; i <= NR; i++) {
                if (i == last_brace) {
                    print "  meta.broken = true;"
                }
                print lines[i]
            }
        }
        ' "$file" > "${file}.tmp" && mv "${file}.tmp" "$file"
    fi
done

echo "=== Done ==="
