#!/usr/bin/env bash
# Remove meta.broken from all packages since we want to let Nix decide
# at fetch/build time if a package is actually broken

set -euo pipefail

PACKAGES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../packages" && pwd)"

for file in "${PACKAGES_DIR}"/*.nix; do
    if grep -q 'meta.broken = true;' "$file"; then
        pkg_name=$(basename "$file" .nix)
        echo "Unmarking broken: $pkg_name"
        sed -i '/meta.broken = true;/d' "$file"
    fi
done

echo "=== Done ==="
