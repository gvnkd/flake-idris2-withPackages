#!/usr/bin/env bash
# Build script for idris2-with-docs registry
# Usage: ./build.sh [package-name|all]

set -uo pipefail

REGISTRY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

build_package() {
    local pkg="$1"
    echo "Building package: $pkg"
    nix build "${REGISTRY_DIR}#packages.x86_64-linux.${pkg}" 2>&1 || {
        echo "  ✗ FAILED: $pkg"
        return 1
    }
    echo "  ✓ SUCCESS: $pkg"
}

build_docs() {
    local pkg="$1"
    echo "Building docs for: $pkg"
    nix build "${REGISTRY_DIR}#packages.x86_64-linux.${pkg}-docs" 2>&1 || {
        echo "  ✗ FAILED: $pkg-docs"
        return 1
    }
    echo "  ✓ SUCCESS: $pkg-docs"
}

build_all() {
    echo "=== Building all packages ==="
    # Get list of all packages from the flake
    local packages
    packages=$(nix eval --json "${REGISTRY_DIR}#packages.x86_64-linux" 2>/dev/null | grep -o '"[a-zA-Z0-9_-]*"' | tr -d '"' | grep -v '^idris2-mkdoc-md$' | grep -v '\-docs$' | sort -u)
    
    local success=0
    local failed=0
    
    for pkg in $packages; do
        if build_package "$pkg"; then
            success=$((success + 1))
        else
            failed=$((failed + 1))
        fi
    done
    
    echo ""
    echo "=== SUMMARY ==="
    echo "Successful: $success"
    echo "Failed: $failed"
}

build_docs_all() {
    echo "=== Building all docs ==="
    local packages
    packages=$(nix eval --json "${REGISTRY_DIR}#packages.x86_64-linux" 2>/dev/null | grep -o '"[a-zA-Z0-9_-]*"' | tr -d '"' | grep -v '^idris2-mkdoc-md$' | grep -v '\-docs$' | sort -u)
    
    local success=0
    local failed=0
    
    for pkg in $packages; do
        if build_docs "$pkg"; then
            success=$((success + 1))
        else
            failed=$((failed + 1))
        fi
    done
    
    echo ""
    echo "=== SUMMARY ==="
    echo "Successful: $success"
    echo "Failed: $failed"
}

# Main
case "${1:-}" in
    "")
        echo "Usage: $0 [package-name|all|docs|docs-all]"
        echo ""
        echo "Examples:"
        echo "  $0 algdata          # Build single package"
        echo "  $0 algdata-docs     # Build docs for single package"
        echo "  $0 all              # Build all packages"
        echo "  $0 docs-all         # Build all docs"
        exit 1
        ;;
    all)
        build_all
        ;;
    docs-all)
        build_docs_all
        ;;
    *-docs)
        pkg="${1%-docs}"
        build_docs "$pkg"
        ;;
    *)
        build_package "$1"
        ;;
esac
