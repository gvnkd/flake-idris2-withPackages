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
├── README.md      # This file
└── .gitignore     # Ignores build artifacts, result, direnv
```

## Adding Dependencies

Edit `flake.nix` and add registry packages to both `selectedLibs` and `idris2Wrapped`:

```nix
selectedLibs = with idris2-withpkgs.packages.${system}; [
  json
  containers
  algebra
];

idris2Wrapped = idris2-withpkgs.lib.${system}.withPackages (p: [
  p.json
  p.containers
  p.algebra
]);
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
idris2-mkdoc-md -o ./docs template.ipkg

# View the generated index
cat ./docs/index.md
```

The docs generator produces GitHub-Flavored Markdown with:
- Module index with links
- Type signatures in fenced code blocks
- Docstrings rendered as plain text
- Public re-exports listed

## Flake Outputs

- `nix build` — Build the executable
- `nix build .#lib` — Build the library
- `nix develop` — Enter dev shell with Idris2 and registry packages

## Renaming the Project

1. Rename `template.ipkg` to `<your-project>.ipkg`
2. Update `package template` → `package <your-project>`
3. Update `executable = template` → `executable = <your-project>`
4. Update `ipkgName = "template"` in `flake.nix`
5. Update references in this README
