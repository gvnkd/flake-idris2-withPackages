#!/usr/bin/env bash
# Mark packages using builtins.fetchGit as broken since they can't be hashed

set -euo pipefail

PACKAGES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../packages" && pwd)"

for file in "${PACKAGES_DIR}"/*.nix; do
    if grep -q 'builtins.fetchGit' "$file"; then
        pkg_name=$(basename "$file" .nix)
        
        if grep -q 'meta.broken' "$file"; then
            continue
        fi
        
        echo "Marking as broken: $pkg_name"
        
        # For single-package files: add meta.broken before the final closing brace
        # For multi-package files: this shouldn't apply since builtins.fetchGit 
        # packages are typically single-package
        
        # Use awk to insert meta.broken = true before the last line that is just }
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
