# Idris2 Project Template

A minimal Idris2 project with Nix flake support, demonstrating JSON encoding via the registry.

## Quick Start

```bash
# Create a new project from this template
nix flake init --template github:gvnkd/flake-idris2-withPackages#default
cd my-project

# Enter dev shell
nix develop

# Build
idris2 --build template.ipkg

# Run
./build/exec/template
# Output: {"text":"Hello from Idris2"}
```

## What this template demonstrates

The example defines a `Message` record, derives `ToJSON` and `FromJSON` instances via elaborator reflection, and prints the encoded JSON:

```idris
record Message where
  constructor MkMessage
  text : String

%runElab derive "Message" [ToJSON, FromJSON]

main : IO ()
main = putStrLn $ encode $ MkMessage "Hello from Idris2"
```

## Project Structure

```
.
├── flake.nix      # Nix flake with devShell and package build
├── template.ipkg  # Idris2 package manifest
├── src/
│   └── Main.idr   # Entry point with JSON example
├── docs/          # Symlink to dependency documentation (created by devShell)
├── README.md      # This file
└── .gitignore     # Ignores build artifacts, result, direnv
```

## Adding Dependencies

Edit `flake.nix` and add registry packages to three places:

1. **Library dependencies** (for compilation):
```nix
idrisLibraries = with idris2-withpkgs.packages.${system}; [
  json
  # containers
  # algebra
];
```

2. **DevShell packages** (for REPL):
```nix
idris2Wrapped = idris2-withpkgs.lib.${system}.withPackages (p: [
  p.json
  # p.containers
]);
```

3. **Documentation packages** (for browsing docs):
```nix
docsPkgs = with idris2-withpkgs.packages.${system}; [
  json-docs
  # containers-docs
];
```

Then add the dependency to `template.ipkg`:

```
depends = json
        , containers
        , algebra
```

Finally, re-enter the devShell to pick up the new packages:

```bash
nix develop
```

## Generating Documentation

The devShell includes `idris2-mkdoc-md` for generating Markdown documentation:

```bash
# Generate docs for your project
idris2-mkdoc-md -o ./my-docs template.ipkg

# View the generated index
cat ./my-docs/index.md
```

The docs generator produces GitHub-Flavored Markdown with:
- Module index with links
- Type signatures in fenced code blocks
- Docstrings rendered as plain text
- Public re-exports listed

## Browsing Dependency Documentation

The devShell provides a `doc` command and a `./docs` symlink for browsing documentation of installed dependencies:

```bash
# List available package docs
doc list

# View a package's index
doc show json

# View a specific module
doc show json JSON.Encoder
doc show http Data.Compress.CRC

# Or browse directly via the symlink
ls ./docs/json/
cat ./docs/json/JSON.Encoder.md
```

If you request a module that doesn't exist, the command lists all available modules for that package.

## Flake Outputs

- `nix build` — Build the executable
- `nix build .#lib` — Build the library
- `nix develop` — Enter dev shell with Idris2, docs, and registry packages

## Renaming the Project

1. Rename `template.ipkg` to `<your-project>.ipkg`
2. Update `package template` → `package <your-project>`
3. Update `executable = template` → `executable = <your-project>`
4. Update `ipkgName = "template"` in `flake.nix`
5. Update references in this README
