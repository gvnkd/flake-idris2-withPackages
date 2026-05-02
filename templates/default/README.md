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
# Output: {"putStrLn":"Hello from Idris2"}
```

## What this template demonstrates

The example defines a `Message` record, derives `ToJSON` and `FromJSON` instances via elaborator reflection, and prints the encoded JSON:

```idris
record Message where
  constructor MkMessage
  putStrLn : String

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

Edit `flake.nix` and add registry packages to `idrisLibraries`:

```nix
idrisLibraries = [
  idris2-withpkgs.packages.${system}.json-simple
  idris2-withpkgs.packages.${system}.containers
];
```

Then add the dependency to `template.ipkg`:

```
depends = json-simple
        , containers
```

## Flake Outputs

- `nix build` — Build the executable
- `nix build .#lib` — Build the library
- `nix develop` — Enter dev shell with Idris2

## Renaming the Project

1. Rename `template.ipkg` to `<your-project>.ipkg`
2. Update `package template` → `package <your-project>`
3. Update `executable = template` → `executable = <your-project>`
4. Update `ipkgName = "template"` in `flake.nix`
