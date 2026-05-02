# HACKING.md — flake-idris2-withPackages Development Guide

This document is a comprehensive guide to understanding, developing, and extending the `flake-idris2-withPackages` Nix flake. It covers the architecture of the flake, how the package registry works, how documentation is generated and browsed, and how to make changes.

## Table of Contents

1. [Overview](#overview)
2. [Flake Architecture](#flake-architecture)
3. [The Docs Generator](#the-docs-generator)
4. [The Package Registry](#the-package-registry)
5. [Dependency Resolution](#dependency-resolution)
6. [Documentation System](#documentation-system)
7. [Build Process](#build-process)
8. [Development Workflow](#development-workflow)
9. [Adding Packages to the Registry](#adding-packages-to-the-registry)
10. [Troubleshooting](#troubleshooting)
11. [Reference](#reference)

---

## Overview

`flake-idris2-withPackages` is a Nix flake that provides:

1. **`idris2-mkdoc-md`** — A standalone executable that generates Markdown documentation for Idris 2 packages
2. **A package registry** — ~200 Idris 2 packages from the idris2-pack-db database, buildable via Nix
3. **`lib.withPackages`** — A function to create a wrapped `idris2` with selected packages on `IDRIS2_PACKAGE_PATH`
4. **`doc-browser`** — A tool for browsing generated documentation
5. **A project template** — A `nix flake init` template for new Idris 2 projects

The flake declares:

- **Inputs**: External flakes (`nixpkgs`, `flake-utils`, `idris2-src`, `idris2-pack-db`)
- **Packages**: The docs generator, all registry libraries, their docs, and bundled doc browsers
- **Library functions**: `withPackages` for creating wrapped Idris 2
- **DevShell**: Development environment for working on the generator and registry
- **Template**: Scaffolding for new projects

---

## Flake Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           flake.nix                                         │
├─────────────────────────────────────────────────────────────────────────────┤
│ Inputs                                                                      │
│   ├── nixpkgs              (NixOS package set)                              │
│   ├── flake-utils          (eachDefaultSystem helper)                       │
│   ├── idris2-src           (Idris 2 compiler + idris2Api library)           │
│   └── idris2-pack-db       (Upstream package database, non-flake input)     │
│                                                                             │
│ Outputs                                                                     │
│   ├── packages.idris2-mkdoc-md        (The docs generator executable)       │
│   ├── packages.<name>                 (Registry library packages)           │
│   ├── packages.<name>-docs            (Generated Markdown docs)             │
│   ├── packages.<name>-docs-with-browser (Docs + wrapped doc-browser)        │
│   ├── packages.all-docs               (Curated bundle of all docs)          │
│   ├── packages.doc-browser            (Standalone doc browser script)       │
│   ├── lib.withPackages                (Create wrapped idris2)               │
│   ├── devShells.default               (Development shell)                   │
│   └── templates.default               (nix flake init template)             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Key Design Decisions

1. **Centralized registry**: All Idris 2 packages are defined in one place (`registry/packages/`), not duplicated per-project.
2. **Recursive dependency resolution**: `pkgs.lib.fix` creates a self-referential attribute set where packages can reference each other by name.
3. **Docs as first-class outputs**: Every package has a corresponding `-docs` output, generated automatically at build time.
4. **Wrapped compiler**: `lib.withPackages` creates an `idris2` binary pre-configured with `IDRIS2_PACKAGE_PATH`, similar to `python3.withPackages`.

---

## The Docs Generator

### What It Does

`idris2-mkdoc-md` is a standalone executable that reads `.ipkg` files, typechecks all modules via the Idris 2 compiler API, and writes GitHub-Flavored Markdown documentation.

For each module in a package, it generates:
- Function/type signatures in ` ```idris ` code fences
- Docstrings rendered as plain text
- Re-exports listed as bullet lists

Output structure:
```
docs/
├── index.md          # Package index with module list
├── Module1.md        # Per-module documentation
├── Module2.md
└── ...
```

### Source Architecture

```
src/
├── Main.idr           # CLI entry point
├── Init.idr           # Compiler environment initialization
├── Package.idr        # .ipkg loading and parsing
├── Scanner.idr        # Module iteration
├── CLI.idr            # Argument parsing
└── Render/
    ├── Markdown.idr   # SimpleDocTree → Markdown renderer
    ├── Module.idr     # Module page assembly
    └── Index.idr      # Package index rendering
```

### Building the Generator

```shell
nix develop
idris2 --build idris2-mkdoc-md.ipkg
./build/exec/idris2-mkdoc-md --help
```

Or via Nix:
```shell
nix build .#idris2-mkdoc-md
./result/bin/idris2-mkdoc-md -o ./docs my-package.ipkg
```

### Key Implementation Details

The generator uses the Idris 2 compiler API (`idris2Api` library) directly. Critical initialization sequence:

1. `updateEnv` from `Idris.Driver` — mandatory for package resolution
2. `Ref Ctxt Defs`, `Ref Syn SyntaxInfo`, `Ref ROpts REPLOpts` — must be initialized before any API calls
3. `processPackageAndWrite` creates a fresh `UST` ref per module because `addImport` requires it

---

## The Package Registry

### Directory Structure

```
registry/
├── packages.nix              # Aggregator — imports all packages/*.nix
├── nix/
│   └── build-idris-with-docs.nix   # Wrapper around nixpkgs buildIdris
├── packages/
│   ├── algebra.nix           # Single package
│   ├── async.nix             # Multi-package source (async, async-js, ...)
│   ├── Idris2GL.nix          # Package with C deps (SDL2)
│   └── ... (~200 files)
└── scripts/
    ├── generate-from-head.py     # Parses upstream HEAD.toml
    ├── extract-deps-from-ipkg.py # Extracts deps from .ipkg files
    ├── pin-fetchgit-revs.sh      # Pins revs for builtins.fetchGit
    └── update-hashes.sh          # Fetches sha256 hashes
```

### Package Definition Format

Each `.nix` file in `registry/packages/` defines one or more packages:

```nix
{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "mylib";                    # Must match .ipkg package name
  ipkg = "mylib.ipkg";                # Path to .ipkg (supports subdirs)
  src = pkgs.fetchFromGitHub {
    owner = "foo";
    repo = "idris2-mylib";
    rev = "main";                     # Use pinned rev for reproducibility
    hash = "sha256-AAAA==";           # Filled by update-hashes.sh
  };
  deps = [ "base-dep" "other-dep" ];  # Resolved recursively at eval time
}
```

Multi-package repositories define multiple packages sharing a `src`:

```nix
{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub { ... };
in
{
  async = buildIdrisWithDocs {
    pname = "async";
    ipkg = "async.ipkg";
    inherit src;
    deps = [ "array" "containers" ];
  };
  
  async-posix = buildIdrisWithDocs {
    pname = "async-posix";
    ipkg = "posix/async-posix.ipkg";
    inherit src;
    deps = [ "async" "posix" ];
  };
}
```

### The `buildIdrisWithDocs` Wrapper

This wrapper around `nixpkgs.idris2Packages.buildIdris` adds automatic docs generation:

```
buildIdrisWithDocs { ... }  →  { libPkg, docs }
```

- `libPkg` — The compiled library (from `basePkg.library { withSource = true; }`)
- `docs` — A derivation that runs `idris2-mkdoc-md` and installs Markdown files

It also handles:
- Transitive dependency collection via `propagatedIdrisLibraries`
- `IDRIS2_PACKAGE_PATH` construction for docs generation
- Passing through patch attrs (`postPatch`, `NIX_CFLAGS_COMPILE`, etc.)

---

## Dependency Resolution

### How It Works

`registry/packages.nix` uses `pkgs.lib.fix` to create a recursive attribute set:

```nix
libs = pkgs.lib.fix (self:
  let
    buildIdrisWithDocs = mkBuildIdrisWithDocs self;
    
    importPackageFile = file:
      let
        name = pkgs.lib.removeSuffix ".nix" file;
        result = import ./packages/${file} { inherit pkgs buildIdrisWithDocs; };
      in
        if builtins.isAttrs result && result ? libPkg
          then { ${result.pname or name} = result; }
          else result;
    
    allPackages = builtins.foldl' (acc: file: acc // (importPackageFile file)) {} nixFiles;
  in
    allPackages
);
```

When `json` declares `deps = [ "elab-util" "parser" ]`:

1. `resolveDep` looks up `self.elab-util` and `self.parser`
2. Built-in packages (`base`, `prelude`, `contrib`, `linear`, `network`, `test`, `idris2`, `idris2api`) are filtered out
3. Unknown dependencies are skipped gracefully (allows optional deps)
4. `idrisLibraries = map (d: d.libPkg or d) resolvedDeps`
5. `buildIdris` propagates transitive deps via `propagatedIdrisLibraries`

### Transitive Dependency Example

Building `json` automatically builds:
- Direct deps: `elab-util`, `parser`
- Transitive: `bytestring`, `algebra`, `array`, `ref1`, `ilex-core`, `ilex-json`, `ilex`, `refined`, ...

You don't declare these — they're resolved automatically from the `.ipkg` files in the upstream sources.

### Updating Dependencies

When upstream packages change their `.ipkg` dependencies:

```shell
nix develop
generate-registry    # Regenerate packages/*.nix from HEAD.toml
./registry/scripts/extract-deps-from-ipkg.py  # Extract deps from .ipkg files
```

The extraction script parses `HEAD.toml` directly, fetches each source, reads its `.ipkg`, and updates `deps = [ ... ]` in the `.nix` files.

---

## Documentation System

### Per-Package Docs

Every registry package has a `-docs` output:

```shell
nix build .#json-docs
ls result/share/doc/json/
# index.md  JSON.md  JSON.Encoder.md  JSON.FromJSON.md  ...
```

### Single-Package Browser Bundles

Per-package bundles include a `doc-browser` pre-configured for that package:

```shell
nix build .#json-docs-with-browser
./result/bin/doc-browser list        # Lists modules in json package
./result/bin/doc-browser show JSON   # Shows JSON.md
```

### Collection-Mode: `all-docs`

The `all-docs` bundle combines curated packages into a browsable collection:

```shell
nix build .#all-docs
./result/bin/doc-browser list        # Lists packages: algebra, json, http2, ...
./result/bin/doc-browser show json   # Shows json/index.md
./result/bin/doc-browser show json JSON.Encoder  # Shows specific module
```

### doc-browser Script

The `doc-browser` script (`scripts/doc-browser`) auto-detects mode:

**Single-package mode** (`DOCS_PATH/index.md` exists):
```shell
doc-browser list              # List modules
doc-browser show ModuleName   # Show ModuleName.md
```

**Collection mode** (`DOCS_PATH` has subdirectories):
```shell
doc-browser list                     # List packages
doc-browser show pkg                 # Show pkg/index.md
doc-browser show pkg ModuleName      # Show pkg/ModuleName.md
```

### Using `lib.withPackages` with Docs

When using `lib.withPackages` in another project, you can also bundle docs:

```nix
projectDocs = pkgs.runCommand "my-project-docs" {
  nativeBuildInputs = [ pkgs.makeWrapper ];
} (
  let
    docsPkgs = [ json-docs http2-docs ];
    linkCommands = map (docsPkg: ''
      if [ -d ${docsPkg}/share/doc ]; then
        for dir in ${docsPkg}/share/doc/*; do
          if [ -d "$dir" ]; then
            name=$(basename "$dir")
            ln -s "$dir" $out/share/doc/"$name"
          fi
        done
      fi
    '') docsPkgs;
  in
  ''
    mkdir -p $out/share/doc
    ${pkgs.lib.concatStringsSep "\n" linkCommands}
    
    mkdir -p $out/bin
    cp ${docBrowser}/bin/doc-browser $out/bin/
    chmod +x $out/bin/doc-browser
    
    wrapProgram $out/bin/doc-browser \
      --set DOCS_PATH "$out/share/doc"
  ''
);
```

---

## Build Process

### Building Registry Packages

```shell
# Build a library
nix build .#algebra

# Build docs
nix build .#algebra-docs

# Build with browser bundle
nix build .#algebra-docs-with-browser

# Build all curated docs
nix build .#all-docs
```

### Building the Generator

```shell
nix build .#idris2-mkdoc-md
./result/bin/idris2-mkdoc-md -o ./docs some-package.ipkg
```

### Build Failures

**Dependency mismatch**:
```
Error: Unknown dependency 'rio' for package 'qutescript'
```
→ The registry now skips unknown deps gracefully. If a build still fails, the dependency may actually be required — add it to the registry or patch locally.

**Hash mismatch**:
```
error: hash mismatch in fixed-output derivation
```
→ Upstream source changed. Run `./registry/scripts/update-hashes.sh <package>`.

**Network error (502)**:
```
curl: (22) The requested URL returned error: 502
```
→ Temporary GitHub outage or repo moved. Check if the repo still exists. For `rev = "main"`, the hash may drift over time — pin to a specific commit.

**Missing C libraries**:
```
error: SDL2.h: No such file or directory
```
→ Add `nativeBuildInputs = [ pkg-config ]; buildInputs = [ SDL2 ];` and `NIX_CFLAGS_COMPILE` to the package definition.

---

## Development Workflow

### Daily Development

```shell
# Enter the devShell
nix develop

# Build the docs generator
idris2 --build idris2-mkdoc-md.ipkg

# Generate docs for a test package
./build/exec/idris2-mkdoc-md -o ./docs test-package.ipkg

# Browse docs
nix build .#json-docs-with-browser
./result/bin/doc-browser list
```

### Adding a Package to the Registry

1. Check if it's in [idris2-pack-db HEAD.toml](https://raw.githubusercontent.com/stefan-hoeck/idris2-pack-db/main/collections/HEAD.toml)

2. Generate package file:
   ```shell
   nix develop
   generate-registry
   ```

3. Update hash:
   ```shell
   ./registry/scripts/update-hashes.sh my-package
   ```

4. Extract dependencies:
   ```shell
   ./registry/scripts/extract-deps-from-ipkg.py
   ```

5. Test build:
   ```shell
   nix build .#my-package
   nix build .#my-package-docs
   ```

### Updating the Entire Registry

```shell
nix develop
generate-registry              # Regenerate all packages from HEAD.toml
./registry/scripts/update-hashes.sh all
./registry/scripts/extract-deps-from-ipkg.py
```

Note: `update-hashes.sh` has a 2-hour TTL to avoid re-fetching recently-updated packages.

### Pinning fetchGit Revisions

For packages using `builtins.fetchGit` (git.sr.ht, codeberg), you must pin the `rev`:

```shell
./registry/scripts/pin-fetchgit-revs.sh
```

This script fetches the current HEAD commit and writes it as `rev = "abc123"` in the `.nix` file. Without this, pure Nix evaluation fails because `builtins.fetchGit` requires a pinned `rev` in flake mode.

---

## Adding Packages to the Registry

### From idris2-pack-db

The `generate-registry` command parses `HEAD.toml` and creates `packages/*.nix` files:

```shell
nix develop
generate-registry
```

This creates files with placeholder hashes (`sha256-AAAA==`).

### Manual Addition

For packages not in idris2-pack-db:

```nix
# registry/packages/mylib.nix
{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "mylib";
  ipkg = "mylib.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "myuser";
    repo = "idris2-mylib";
    rev = "v1.0.0";  # Pin to a tag or commit
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };
  deps = [ "base" "containers" ];  # Will be resolved at eval time
}
```

Then fetch the hash:
```shell
./registry/scripts/update-hashes.sh mylib
```

### Multi-Package Repositories

Some repositories contain multiple `.ipkg` files:

```nix
{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-async";
    rev = "main";
    hash = "sha256-...";
  };
in
{
  async = buildIdrisWithDocs {
    pname = "async";
    ipkg = "async.ipkg";
    inherit src;
    deps = [ "array" "containers" "elin" ];
  };
  
  async-js = buildIdrisWithDocs {
    pname = "async-js";
    ipkg = "js/async-js.ipkg";
    inherit src;
    deps = [ "async" "dom" "js" ];
  };
}
```

### C Dependencies

Packages with external C libraries need additional attrs:

```nix
buildIdrisWithDocs {
  pname = "idrisGL";
  ipkg = "idrisGL.ipkg";
  src = ...;
  
  nativeBuildInputs = with pkgs; [ gnumake pkg-config ];
  buildInputs = with pkgs; [ SDL2 SDL2_image SDL2_ttf ];
  
  NIX_CFLAGS_COMPILE = [
    "-I${pkgs.SDL2.dev}/include/SDL2"
    "-I${pkgs.SDL2_image}/include/SDL2"
  ];
  
  postPatch = ''
    substituteInPlace src/c_src/Makefile \
      --replace-fail 'SDL_FLAG := -lSDL2' \
        'SDL_FLAG := $(shell pkg-config --libs sdl2)'
  '';
}
```

These attrs are passed through to both `buildIdris` (for compilation) and the docs derivation (for patching sources before doc generation).

---

## Troubleshooting

### "Unknown dependency 'X' for package 'Y'"

The registry's dependency resolver found a dependency name that doesn't exist in the registry.

**Fix**: The resolver now skips unknown dependencies gracefully (returns `null` instead of throwing). If a package still fails to build, the dependency may be required — either add it to the registry or add it as a built-in in `build-idris-with-docs.nix`.

### "hash mismatch in fixed-output derivation"

An upstream source changed (force-push, new commit on `main` branch).

**Fix**:
```shell
./registry/scripts/update-hashes.sh my-package
```

For `builtins.fetchGit` packages, also run:
```shell
./registry/scripts/pin-fetchgit-revs.sh
```

### "Cannot build ... source.drv" (network error)

GitHub returned 502 or the repo no longer exists.

**Fix**: Check if the repository URL is still valid. If the repo was moved or deleted, update or remove the package definition.

### "Required X any but no matching version is installed"

This error occurs in projects *consuming* the registry, not in the registry itself. The project's `.ipkg` declares a dependency that wasn't included in `idrisLibraries`.

**Fix**: Ensure the project's `flake.nix` includes all packages declared in its `.ipkg` file. Note that package names in `.ipkg` (e.g., `http2`) may differ from registry attribute names (e.g., `http2` is both in this case, but always verify).

### Docs show empty package list

The `all-docs` bundle or a custom docs bundle didn't find any docs.

**Fix**: Check that the `-docs` packages build individually:
```shell
nix build .#json-docs
ls result/share/doc/
```

### "attribute 'doc-browser' missing"

You're using an old version of the registry that doesn't have `doc-browser` yet.

**Fix**: Update your flake input:
```shell
nix flake update idris2-withpkgs
```

### "builtins.fetchGit requires a locked reference"

A package uses `builtins.fetchGit` without a pinned `rev`.

**Fix**: Run the pinning script:
```shell
./registry/scripts/pin-fetchgit-revs.sh
```

---

## Reference

### Flake Outputs

| Output | Description |
|--------|-------------|
| `.#idris2-mkdoc-md` | The docs generator executable |
| `.#default` | Alias for `idris2-mkdoc-md` |
| `.#<name>` | Registry library package (e.g., `.#json`) |
| `.#<name>-docs` | Generated Markdown docs |
| `.#<name>-docs-with-browser` | Docs + wrapped doc-browser |
| `.#all-docs` | Curated bundle of 20 packages |
| `.#doc-browser` | Standalone doc-browser script |
| `.#generate-registry` | Script to regenerate packages from HEAD.toml |

### DevShell Commands

| Command | Description |
|---------|-------------|
| `generate-registry` | Regenerate `packages/*.nix` from upstream `HEAD.toml` |

### Registry Scripts

| Script | Purpose |
|--------|---------|
| `registry/scripts/generate-from-head.py` | Parses `HEAD.toml` → `packages/*.nix` |
| `registry/scripts/extract-deps-from-ipkg.py` | Fetches sources, reads `.ipkg`, updates `deps` |
| `registry/scripts/update-hashes.sh` | Fetches `sha256` hashes (2h TTL) |
| `registry/scripts/pin-fetchgit-revs.sh` | Pins `rev` for `builtins.fetchGit` packages |

### Key Files

| File | Purpose |
|------|---------|
| `flake.nix` | Flake definition |
| `registry/packages.nix` | Package aggregator with recursive resolution |
| `registry/nix/build-idris-with-docs.nix` | `buildIdris` wrapper with docs generation |
| `registry/packages/*.nix` | Individual package definitions |
| `scripts/doc-browser` | Documentation browsing script |

### Nix Commands

```shell
# Update all inputs
nix flake update

# Update specific input
nix flake update idris2-src

# Build specific output
nix build .#idris2-mkdoc-md
nix build .#json-docs
nix build .#all-docs

# Enter devShell
nix develop

# List all packages
nix eval --impure --expr "
  let flake = builtins.getFlake \"path:.\";
  in builtins.attrNames flake.packages.x86_64-linux
"

# Check flake
nix flake check
```

### Using in Another Project

```nix
{
  inputs.idris2-withpkgs.url = "github:gvnkd/flake-idris2-withPackages";

  outputs = { self, nixpkgs, flake-utils, idris2-withpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        
        # Select packages
        myLibs = with idris2-withpkgs.packages.${system}; [ json containers ];
        
        # Wrapped idris2 with packages
        idris2Wrapped = idris2-withpkgs.lib.${system}.withPackages (p: [
          p.json
          p.containers
        ]);
      in
      {
        packages.default = pkgs.idris2Packages.buildIdris {
          src = ./.;
          ipkgName = "myproject";
          idrisLibraries = myLibs;
        }.executable;
        
        devShells.default = pkgs.mkShell {
          buildInputs = [ idris2Wrapped ];
        };
      }
    );
}
```

---

## Contributing

When modifying the flake or registry:

1. **Test builds**: Always build affected packages:
   ```shell
   nix build .#my-package .#my-package-docs
   ```

2. **Update hashes**: If you changed a package's `rev` or URL:
   ```shell
   ./registry/scripts/update-hashes.sh my-package
   ```

3. **Test the generator**: If you changed `idris2-mkdoc-md`:
   ```shell
   nix build .#idris2-mkdoc-md
   nix build .#json-docs  # Test docs generation
   ```

4. **Commit both `flake.nix` and `flake.lock`** if inputs changed.

5. **Pin fetchGit revs** before committing if you added new `builtins.fetchGit` packages.

---

*This document is maintained alongside the flake. When the flake changes, update this document.*
