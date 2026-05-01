# idris2-with-docs

Nix flake registry for Idris2 packages with automatic Markdown documentation generation.

## Overview

This registry extends the Idris2 ecosystem with automatic API documentation in Markdown format. Every package provides two outputs:

- `packages.<system>.<name>` — the compiled Idris2 library
- `packages.<system>.<name>-docs` — Markdown API documentation

## Quick Start

```bash
# Build a single package
nix build .#algdata

# Build docs for a single package
nix build .#algdata-docs

# Build idrisGL (with external SDL2 deps)
nix build .#idrisGL
nix build .#idrisGL-docs

# Enter development shell with all packages
nix develop
```

## Registry Structure

```
registry/
├── flake.nix              # Flake inputs (nixpkgs, flake-utils, idris2-src)
├── flake.lock             # Lock file
├── packages.nix           # Aggregator: imports all packages/*.nix
├── packages/              # One file per package (or package group)
│   ├── algdata.nix        # Simple package with no deps
│   ├── array.nix          # Package with Idris deps
│   ├── idrisGL.nix        # Package with external C deps
│   ├── algebra.nix
│   ├── ansi.nix
│   ├── containers.nix
│   ├── elab-util.nix
│   ├── graph.nix
│   ├── json.nix
│   ├── parser.nix
│   └── ref1.nix
├── nix/
│   └── build-idris-with-docs.nix  # buildIdrisWithDocs helper
├── build.sh               # Batch build script
├── scripts/
│   └── update-hashes.sh   # Update source hashes
└── README.md              # This file
```

## Adding a New Package

Create a file in `packages/<name>.nix`:

```nix
# packages/my-pkg.nix
{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "my-pkg";
  ipkg = "my-pkg.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "my-org";
    repo = "idris2-my-pkg";
    rev = "main";  # or specific commit hash
    hash = "sha256-AAAA";  # run: ./scripts/update-hashes.sh my-pkg
  };
  deps = [ "base" "elab-util" ];  # Idris dependencies (by name)
}
```

If the package has external C dependencies:

```nix
buildIdrisWithDocs {
  pname = "my-pkg";
  ipkg = "my-pkg.ipkg";
  src = pkgs.fetchFromGitHub { ... };
  deps = [ "base" ];
  cDeps = [ pkgs.postgresql ];  # C library dependencies
  nativeBuildInputs = [ pkgs.pkg-config ];
  NIX_CFLAGS_COMPILE = [ "-I${pkgs.postgresql}/include" ];
}
```

### Multiple Packages from One Source

Some repos provide multiple packages (e.g., `idris2-async` provides `async`, `async-dom`, `async-posix`, etc.):

```nix
# packages/idris2-async.nix
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

  async-dom = buildIdrisWithDocs {
    pname = "async-dom";
    ipkg = "async-dom.ipkg";
    inherit src;
    deps = [ "async" "dom" ];
  };
}
```

## Updating Source Hashes

When a package source changes (new commits on `main`), update the hash:

```bash
# Update single package
./scripts/update-hashes.sh my-pkg

# Update all packages (takes a while)
./scripts/update-hashes.sh all
```

## Batch Building

```bash
# Build all packages
./build.sh all

# Build all docs
./build.sh docs-all

# Build single package
./build.sh algdata

# Build single docs
./build.sh algdata-docs
```

## How It Works

1. **nixpkgs `buildIdris`** — builds Idris2 libraries with proper dependency resolution
2. **`buildIdrisWithDocs`** — wrapper that adds a `.docs` derivation using `idris2-mkdoc-md`
3. **Transitive deps** — `packages.nix` resolves all dependencies recursively via `pkgs.lib.fix`
4. **External deps** — C libraries declared via `cDeps` are passed to both library and docs derivations

## Available Packages

Run `nix eval .#packages.x86_64-linux --json | jq -r 'keys[]'` to list all packages.

## License

MIT — same as the upstream packages.
