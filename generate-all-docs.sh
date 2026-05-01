#!/usr/bin/env bash
set -euo pipefail

MKDOC="/srv/idris2-mkdoc-md/build/exec/idris2-mkdoc-md"
OUT_BASE="/srv/idris2-mkdoc-md/generated/docs"
LIBS_DIR="/srv/ai/libs_sources"

mkdir -p "$OUT_BASE"

# Find top-level .ipkg files (not in subdirs like tests/, examples/, docs/, profile/, etc.)
find "$LIBS_DIR" -maxdepth 2 -name "*.ipkg" | while read -r ipkg; do
    dir=$(dirname "$ipkg")
    name=$(basename "$ipkg" .ipkg)
    
    # Skip if in excluded subdirectories
    case "$dir" in
        */tests/*|*/test/*|*/examples/*|*/example/*|*/docs/*|*/profile/*|*/bench/*|*/app/*|*/nix/*|*/samples/*)
            continue
            ;;
    esac
    
    # Skip idris2 compiler itself (too big, different structure)
    if [[ "$dir" == *"/Idris2"* ]]; then
        continue
    fi
    
    out_dir="$OUT_BASE/$name"
    echo "Processing: $name ($ipkg)"
    
    if "$MKDOC" -o "$out_dir" "$ipkg" 2>/dev/null; then
        echo "  ✓ Generated docs in $out_dir"
    else
        echo "  ✗ Failed to generate docs for $name"
    fi
done

echo "Done. Output in $OUT_BASE"
