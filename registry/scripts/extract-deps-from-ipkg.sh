#!/usr/bin/env bash
# Extract dependencies from .ipkg files and update packages/*.nix
#
# Usage:
#   ./scripts/extract-deps-from-ipkg.sh [package-name]
#
# If package-name is given, only process that package.
# Otherwise process all packages.

set -euo pipefail

PACKAGES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../packages" && pwd)"
FLAKE_ROOT="$(cd "${PACKAGES_DIR}/.." && pwd)"
SYSTEM="${SYSTEM:-$(nix eval --impure --expr 'builtins.currentSystem' --raw 2>/dev/null || echo 'x86_64-linux')}"

# Extract deps from an .ipkg file
extract_deps() {
    local ipkg_path="$1"
    # Parse depends = line(s), handling multiline and end-of-file
    awk '
        BEGIN { deps = ""; in_deps = 0 }
        /^depends\s*=/ {
            in_deps = 1
            line = $0
            sub(/^depends\s*=\s*/, "", line)
            deps = line
            next
        }
        in_deps && /^[[:space:]]/ {
            deps = deps " " $0
            next
        }
        in_deps {
            print deps
            exit
        }
        END {
            if (in_deps && deps != "") {
                print deps
            }
        }
    ' "$ipkg_path" | tr ',' '\n' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | \
        sed 's/[[:space:]]*>=.*//;s/[[:space:]]*>.*//;s/[[:space:]]*<=.*//;s/[[:space:]]*<.*//' | \
        grep -v '^$' | grep -vE '^(prelude|base|contrib|linear|network|test)$' | sort -u
}

# Update deps in a .nix file
update_deps() {
    local nix_file="$1"
    shift
    local deps=("$@")

    if [ ${#deps[@]} -eq 0 ]; then
        # Empty deps
        sed -i 's/deps = \[.*\];/deps = [ ];/' "$nix_file"
    else
        # Build deps string
        local deps_str=""
        for dep in "${deps[@]}"; do
            if [ -z "$deps_str" ]; then
                deps_str="\"$dep\""
            else
                deps_str="$deps_str \"$dep\""
            fi
        done
        sed -i "s/deps = \[.*\];/deps = [ $deps_str ];/" "$nix_file"
    fi
}

# Process a single package
process_package() {
    local file_name="$1"
    local nix_file="${PACKAGES_DIR}/${file_name}.nix"

    if [ ! -f "$nix_file" ]; then
        echo "⚠ $file_name: .nix file not found"
        return 1
    fi

    # Extract pname and ipkg from .nix file
    local pname
    pname=$(grep -oP 'pname\s*=\s*"\K[^"]+' "$nix_file" || echo "")
    if [ -z "$pname" ]; then
        echo "⚠ $file_name: Could not extract pname"
        return 1
    fi

    local ipkg_name
    ipkg_name=$(grep -oP 'ipkg\s*=\s*"\K[^"]+' "$nix_file" || echo "")
    if [ -z "$ipkg_name" ]; then
        echo "⚠ $file_name: Could not extract ipkg name"
        return 1
    fi

    echo -n "Processing $pname (file: $file_name, ipkg: $ipkg_name)... "

    # Get source path using nix - use pname for lookup
    local src_path
    if ! src_path=$(nix eval --impure --expr "
      let
        flake = builtins.getFlake \"path:${FLAKE_ROOT}\";
        pkg = flake.packages.\${builtins.currentSystem}.${pname} or null;
      in
        if pkg == null then throw \"Package not found\" else pkg.src.outPath
    " --raw 2>/dev/null); then
        echo "FAILED (nix eval error for pname=${pname})"
        return 1
    fi

    # Find .ipkg file
    local ipkg_path=""
    if [ -f "${src_path}/${ipkg_name}" ]; then
        ipkg_path="${src_path}/${ipkg_name}"
    elif [ -f "${src_path}/$(basename "$ipkg_name")" ]; then
        ipkg_path="${src_path}/$(basename "$ipkg_name")"
    fi

    if [ -z "$ipkg_path" ]; then
        echo "FAILED (.ipkg not found in ${src_path})"
        return 1
    fi

    # Extract deps
    local deps=()
    while IFS= read -r dep; do
        deps+=("$dep")
    done < <(extract_deps "$ipkg_path")

    if [ ${#deps[@]} -eq 0 ]; then
        echo "no deps"
    else
        echo "deps: ${deps[*]}"
    fi

    # Update .nix file
    update_deps "$nix_file" "${deps[@]}"
    return 0
}

# Main
if [ $# -eq 1 ]; then
    process_package "$1"
else
    echo "Processing all packages..."
    success=0
    failed=0
    for nix_file in "${PACKAGES_DIR}"/*.nix; do
        file_name=$(basename "$nix_file" .nix)
        if process_package "$file_name"; then
            success=$((success + 1))
        else
            failed=$((failed + 1))
        fi
    done
    echo ""
    echo "Done: $success succeeded, $failed failed"
fi
