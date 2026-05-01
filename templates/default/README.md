# Idris2 Project Template

A minimal skeleton for Idris2 projects with Nix flake support.

## Quick Start

```bash
# Create a new project from this template
nix init --template github:gvnkd/flake-idris2-withPackages#default my-project
cd my-project

# Enter dev shell
nix develop

# Build
idris2 --build template.ipkg

# Run
./build/exec/template
```

## Project Structure

```
.
├── flake.nix      # Nix flake with devShell and package build
├── template.ipkg  # Idris2 package manifest
├── src/
│   └── Main.idr   # Entry point
└── README.md      # This file
```

## Adding Dependencies

Edit `flake.nix` and add registry packages to `idrisLibraries`:

```nix
idrisLibraries = [
  idris2-withpkgs.packages.${system}.json
  idris2-withpkgs.packages.${system}.containers
];
```

Then add the dependency to `template.ipkg`:

```
depends = json
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
