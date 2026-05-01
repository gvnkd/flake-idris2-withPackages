#!/usr/bin/env bash
set -uo pipefail

LIBS_DIR="/srv/ai/libs_sources"
INSTALL_PREFIX="$LIBS_DIR/.idris2-local"
export IDRIS2_PREFIX="$INSTALL_PREFIX"

mkdir -p "$INSTALL_PREFIX"

# Collect all top-level .ipkg files (same filtering as generate-libs.sh)
declare -a IPKGS=()
while IFS= read -r ipkg; do
    dir=$(dirname "$ipkg")
    
    # Skip Idris2 compiler itself (already installed)
    if [[ "$dir" == *"/Idris2"* ]]; then
        continue
    fi
    
    # Skip test/example subdirectories
    case "$dir" in
        */tests/*|*/test/*|*/examples/*|*/example/*|*/docs/*|*/profile/*|*/bench/*|*/app/*|*/nix/*|*/samples/*)
            continue
            ;;
    esac
    
    IPKGS+=("$ipkg")
done < <(find "$LIBS_DIR" -maxdepth 2 -name "*.ipkg" | sort)

echo "Found ${#IPKGS[@]} packages to build"
echo "Installing to: $INSTALL_PREFIX"
echo ""

# Iteratively build and install until no new packages succeed
installed=0
iteration=0

while true; do
    iteration=$((iteration + 1))
    new_installed=0
    remaining=0
    
    for ipkg in "${IPKGS[@]}"; do
        name=$(basename "$ipkg" .ipkg)
        
        # Skip if already installed
        if [ -d "$INSTALL_PREFIX/idris2-0.8.0/$name"* ] 2>/dev/null; then
            continue
        fi
        
        remaining=$((remaining + 1))
        
        if idris2 --build "$ipkg" >"/tmp/build-$name.log" 2>&1; then
            idris2 --install "$ipkg" >>"/tmp/build-$name.log" 2>&1
            echo "  ✓ INSTALLED: $name"
            new_installed=$((new_installed + 1))
        fi
    done
    
    installed=$((installed + new_installed))
    
    if [ "$new_installed" -eq 0 ]; then
        break
    fi
    
    echo ""
    echo "Iteration $iteration: installed $new_installed packages, $remaining remaining"
done

echo ""
echo "=== BUILD SUMMARY ==="
echo "Installed: $installed"
echo "Failed (missing deps or build errors): $remaining"
echo "Install prefix: $INSTALL_PREFIX"
echo ""
echo "Add this to your environment or flake.nix IDRIS2_PACKAGE_PATH:"
echo "  $INSTALL_PREFIX/idris2-0.8.0"
