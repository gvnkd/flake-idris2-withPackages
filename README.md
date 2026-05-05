# idris2-mkdoc-md

Markdown documentation generator for Idris2 packages, plus a Nix flake registry that builds any Idris2 package and generates its Markdown docs with all dependencies resolved automatically.

## TL;DR

```bash
# --- Start a new Idris2 project from the template ---
nix flake init --template github:gvnkd/flake-idris2-withPackages#default
nix develop                    # Enter shell with Idris2
idris2 --build template.ipkg   # Build your project
./build/exec/template          # Run it

# --- Build any package from the registry ---
cd registry
nix build .#algebra            # Build a library
nix build .#algebra-docs       # Generate its Markdown docs
nix build .#json               # Packages with transitive deps resolve automatically

# --- Work on the docs generator itself ---
nix develop                    # Shell has idris2 + idris2-mkdoc-md
idris2 --build idris2-mkdoc-md.ipkg

# --- Update source hashes after adding packages ---
cd registry
bash scripts/update-hashes.sh all    # Fetches all sha256 hashes (use your GH creds)

# --- Build custom executables ---
nix build .#fmt                          # Idris2 source code formatter
nix build .#taiga-cli                    # Taiga project management CLI
nix build .#optparse-applicative-example # CLI parser demo

# --- Add registry deps to your project ---
# In your project's flake.nix:
idrisLibraries = [ idris2-withpkgs.packages.${system}.json ];
# In your .ipkg:
depends = json
```

## What is this?

This repo contains three things:

1. **`idris2-mkdoc-md`** — A standalone executable that reads `.ipkg` files, typechecks all modules via the Idris2 compiler API, and writes GitHub-Flavored Markdown documentation (one `.md` per module, plus an `index.md`).

2. **`registry/`** — A Nix flake with ~165 Idris2 packages from the [idris2-pack-db](https://github.com/stefan-hoeck/idris2-pack-db) database. Each package definition includes its Git source, `sha256` hash, and dependency list extracted from its `.ipkg`. The registry uses `pkgs.lib.fix` for recursive transitive dependency resolution, so if you build `json`, it automatically builds `parser`, `ilex-core`, `bytestring`, etc. first.

3. **`templates/default/`** — A `nix flake init` template that scaffolds a minimal Idris2 project with `flake.nix`, `.ipkg`, and a `src/Main.idr` entry point. The template's flake references the registry, so adding dependencies is a one-liner.

## Architecture

### The Docs Generator

The generator (`src/`) uses the Idris2 compiler API directly (via `idris2Api` library). It:

1. Initializes the compiler environment (`Init.idr`) — loads `Ctxt`/`Syn`/`ROpts` refs, primitives, package path
2. Loads the `.ipkg` (`Package.idr`) — parses `parsePkgFile`, runs `check`
3. Iterates over all modules in the package (`Scanner.idr`)
4. For each module, extracts `Decl`arations and renders their `SimpleDocTree IdrisDocAnn` as Markdown (`Render/Markdown.idr`)
5. Writes one file per module (`Render/Module.idr`) and an `index.md` (`Render/Index.idr`)

Output is plain GitHub-Flavored Markdown:
- Code signatures wrapped in ` ```idris ` fences
- Docstrings rendered as plain text
- Re-exports listed as bullet lists
- Empty sections stripped

### The Registry

```
registry/
├── flake.nix              # Entry flake — exposes all packages + template
├── packages.nix           # Aggregator — imports all packages/*.nix with recursive deps
├── nix/
│   └── build-idris-with-docs.nix   # Wrapper around nixpkgs buildIdris
├── packages/
│   ├── algebra.nix        # Single package
│   ├── async.nix          # Multi-package source (async, async-js, async-posix, ...)
│   ├── Idris2GL.nix       # Package with external C deps (SDL2)
│   └── ... (165 files)
└── scripts/
    ├── generate-from-head.py   # Parses upstream HEAD.toml → packages/*.nix
    ├── extract-all-deps.py     # Fetches sources, reads .ipkg, extracts deps
    ├── populate-deps.py        # Writes deps = [ ] into packages/*.nix
    ├── update-hashes.sh        # Fetches sha256 for all packages with TTL (2h)
    └── mark-broken.sh          # Marks builtins.fetchGit packages as meta.broken
```

Each package file defines:
- `pname` — package name (must match `.ipkg` package declaration)
- `ipkg` — path to `.ipkg` file (supports subdirectories like `core/ilex-core.ipkg`)
- `src` — `fetchFromGitHub`/`fetchFromGitLab`/`builtins.fetchGit`
- `deps` — list of dependency names (strings), resolved recursively at evaluation time
- `cDeps` / `nativeBuildInputs` / `postPatch` / `NIX_CFLAGS_COMPILE` — passed through to `buildIdris`

### Dependency Resolution

`registry/packages.nix` uses `pkgs.lib.fix` to create a recursive attribute set where each package can reference others by name:

```nix
libs = pkgs.lib.fix (self:
  let
    buildIdrisWithDocs = mkBuildIdrisWithDocs self;
    importPackageFile = file: ...;
  in
    builtins.foldl' (acc: file: acc // (importPackageFile file)) {} nixFiles
);
```

When `async` declares `deps = [ "array" "containers" "elin" "quantifiers-extra" ]`, the build helper:
1. Resolves each name to `self.<name>.libPkg`
2. Collects all transitive dependencies via `propagatedIdrisLibraries`
3. Constructs `IDRIS2_PACKAGE_PATH` automatically
4. Passes the resolved derivations to `nixpkgs.idris2Packages.buildIdris`

Built-in packages (`base`, `prelude`, `contrib`, `linear`, `network`, `test`) are provided by the Idris2 compiler and are excluded from `deps` automatically.

### Custom Packages

In addition to the auto-generated registry from `idris2-pack-db`, the flake maintains a set of custom packages in `registry/custom-packages.nix`:

| Package | Type | Description |
|---------|------|-------------|
| `fmt` | Executable | Source code formatter for Idris 2 |
| `optparse-applicative` | Library | Applicative CLI option parser |
| `optparse-applicative-example` | Executable | Demo app for optparse-applicative |
| `taiga-cli` | Executable | Taiga project management CLI tool |

These are built with the same `buildIdrisWithDocs` infrastructure and participate in dependency resolution just like auto-generated packages. To build:

```bash
nix build .#fmt
nix build .#taiga-cli
nix build .#optparse-applicative-example
```

## Building the Docs Tool

```bash
# From repo root
nix develop
idris2 --build idris2-mkdoc-md.ipkg
./build/exec/idris2-mkdoc-md --help
```

Or via Nix:
```bash
nix build .#idris2-mkdoc-md
./result/bin/idris2-mkdoc-md -o ./docs my-package.ipkg
```

## Using the Registry

```bash
cd registry

# List available packages
nix eval --impure --expr 'let f = builtins.getFlake (toString ./.); in builtins.attrNames f.packages.x86_64-linux'

# Build a library
nix build .#algebra

# Build with transitive deps
nix build .#json        # builds parser, ilex-core, bytestring, refined, ... automatically

# Generate docs
nix build .#json-docs
ls result/share/doc/json/

# Browse docs interactively
nix build .#json-docs-with-browser
./result/bin/doc-browser list         # List modules
./result/bin/doc-browser show JSON    # View JSON.md

# Browse multiple packages at once
nix build .#all-docs
./result/bin/doc-browser list              # List packages
./result/bin/doc-browser show json         # View json index
./result/bin/doc-browser show json JSON.Encoder  # View specific module

# Build custom executables
nix build .#fmt                          # Source code formatter
nix build .#taiga-cli                    # Taiga CLI tool
nix build .#optparse-applicative-example # Demo CLI app

# Enter a shell with all registry libraries available
nix develop
```

### Adding a New Package to the Registry

There are two ways to add packages:

**Option 1: Auto-generated from upstream (`idris2-pack-db`)**

1. Check if it's in [idris2-pack-db](https://raw.githubusercontent.com/stefan-hoeck/idris2-pack-db/main/collections/HEAD.toml):
   ```bash
   curl -sL https://raw.githubusercontent.com/stefan-hoeck/idris2-pack-db/main/collections/HEAD.toml > /tmp/HEAD.toml
   nix run nixpkgs#python3 -- scripts/generate-from-head.py /tmp/HEAD.toml
   ```

2. Fetch the hash:
   ```bash
   bash scripts/update-hashes.sh mylib
   ```

3. Extract dependencies from its `.ipkg`:
   ```bash
   nix run nixpkgs#python3 -- scripts/extract-all-deps.py
   nix run nixpkgs#python3 -- scripts/populate-deps.py
   ```

**Option 2: Custom packages (`registry/custom-packages.nix`)**

For personal projects, packages not in `idris2-pack-db`, or executable applications, add them to `registry/custom-packages.nix` instead of the auto-generated `packages/` directory:

```nix
{ pkgs, buildIdrisWithDocs }:
let
  my-src = pkgs.fetchFromGitHub {
    owner = "myuser";
    repo = "idris2-mypkg";
    rev = "main";
    hash = "sha256-AAAA";  # placeholder — fetch real hash
  };
in
{
  mypkg = buildIdrisWithDocs {
    pname = "mypkg";
    ipkg = "mypkg.ipkg";
    src = my-src;
    deps = [ "json" "containers" ];
  };

  mypkg-app = buildIdrisWithDocs {
    pname = "mypkg-app";
    ipkg = "app.ipkg";
    src = my-src;
    deps = [ "mypkg" ];
  };
}
```

Custom packages are automatically merged into the registry and exposed as flake outputs. The `buildIdrisWithDocs` helper provides three outputs per package:
- `libPkg` — the library (for use as a dependency)
- `executable` — the compiled binary (if the `.ipkg` defines one)
- `docs` — generated Markdown documentation

## Using the Project Template

```bash
# Create a new project
mkdir my-project && cd my-project
nix flake init --template github:gvnkd/flake-idris2-withPackages#default

# The template creates:
#   flake.nix      — Nix flake with devShell and build
#   template.ipkg  — Idris2 package manifest
#   src/Main.idr   — Entry point

# Build and run
nix build
./result/bin/template        # Hello, Idris2!

# Or develop interactively
nix develop
idris2 --build template.ipkg
./build/exec/template
```

### Adding Registry Dependencies to Your Project

Edit `flake.nix`:

```nix
{
  inputs.idris2-withpkgs.url = "github:gvnkd/flake-idris2-withPackages";

  outputs = { self, nixpkgs, flake-utils, idris2-withpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        idris2 = idris2-withpkgs.inputs.idris2-src.packages.${system}.idris2;

        idrisLibraries = [
          idris2-withpkgs.packages.${system}.json
          idris2-withpkgs.packages.${system}.containers
        ];

        pkg = pkgs.idris2Packages.buildIdris {
          src = ./.;
          ipkgName = "template";
          inherit idrisLibraries;
        };
      in {
        packages.default = pkg.executable;
        devShells.default = pkgs.mkShell {
          buildInputs = [ idris2 ];
        };
      }
    );
}
```

Edit `template.ipkg`:

```
package template

modules = Main

main = Main
executable = template

depends = json
        , containers

sourcedir = "src"
```

## Registry Scripts Reference

| Script | Purpose |
|--------|---------|
| `scripts/generate-from-head.py` | Parses upstream `HEAD.toml` and generates all `packages/*.nix` files |
| `scripts/extract-all-deps.py` | Fetches every source, reads `.ipkg`, writes `deps-extracted.json` |
| `scripts/populate-deps.py` | Reads `deps-extracted.json` and writes `deps = [ ... ]` into each `.nix` file |
| `scripts/update-hashes.sh` | Fetches `sha256` hashes. Skips recently-updated packages (2h TTL) |
| `scripts/mark-broken.sh` | Marks `builtins.fetchGit` packages as `meta.broken = true` |

## Status

- [x] Core docs generator (typecheck → markdown)
- [x] Nix flake with `buildIdrisWithDocs` wrapper
- [x] Registry with 165+ auto-generated packages from `idris2-pack-db`
- [x] Custom packages set (`registry/custom-packages.nix`) for personal/executable packages
- [x] Executable exposure — build and run CLI tools from the registry
- [x] Automatic dependency extraction from `.ipkg` files
- [x] Recursive transitive dependency resolution
- [x] Subdirectory `.ipkg` support (e.g. `core/ilex-core.ipkg`)
- [x] Built-in package filtering (`base`, `prelude`, `contrib`, `linear`, `network`, `test`)
- [x] Broken package handling for unhashable sources
- [x] Flake template for new projects
- [x] Verified builds: `algebra`, `array`, `containers`, `hashable`, `json`, `hedgehog`, `async`, `ilex-core`, `fmt`, `taiga-cli`

## Development

See [`docs/HACKING.md`](docs/HACKING.md) for a comprehensive guide to the flake architecture, registry system, dependency resolution, documentation generation, and development workflow.

## License

MIT
