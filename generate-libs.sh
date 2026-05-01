#!/usr/bin/env bash
set -uo pipefail

MKDOC="/srv/idris2-mkdoc-md/build/exec/idris2-mkdoc-md"
OUT_BASE="/srv/idris2-mkdoc-md/generated/docs"
LIBS_DIR="/srv/ai/libs_sources"

mkdir -p "$OUT_BASE"

# Find top-level .ipkg files (maxdepth 2 to catch root-level packages)
find "$LIBS_DIR" -maxdepth 2 -name "*.ipkg" | sort | while read -r ipkg; do
    dir=$(dirname "$ipkg")
    name=$(basename "$ipkg" .ipkg)
    
    # Skip Idris2 compiler itself (handled separately)
    if [[ "$dir" == *"/Idris2"* ]]; then
        continue
    fi
    
    # Skip if in excluded subdirectories
    case "$dir" in
        */tests/*|*/test/*|*/examples/*|*/example/*|*/docs/*|*/profile/*|*/bench/*|*/app/*|*/nix/*|*/samples/*)
            continue
            ;;
    esac
    
    # Skip if already generated (standard libs)
    if [ -d "$OUT_BASE/$name" ] && [ "$(ls -A "$OUT_BASE/$name")" ]; then
        echo "SKIP: $name (already exists)"
        continue
    fi
    
    out_dir="$OUT_BASE/$name"
    echo "PROCESSING: $name ($ipkg)"
    
    if "$MKDOC" -o "$out_dir" "$ipkg" 2>/tmp/mkdoc-$name.log; then
        echo "  ✓ SUCCESS: $name"
    else
        echo "  ✗ FAILED: $name (see /tmp/mkdoc-$name.log)"
    fi
done

echo ""
echo "=== SUMMARY ==="
echo "Generated docs in $OUT_BASE"
echo "Successful: $(find $OUT_BASE -name index.md | wc -l)"
echo "Failed: $(ls /tmp/mkdoc-*.log 2>/dev/null | wc -l)"
