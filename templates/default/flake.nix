{
  description = "Idris2 project template with registry packages and docs generation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    idris2-withpkgs.url = "github:gvnkd/flake-idris2-withPackages";
  };

  outputs = { self, nixpkgs, flake-utils, idris2-withpkgs }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        idris2 = idris2-withpkgs.inputs.idris2-src.packages.${system}.idris2;

        # Select registry packages to use as dependencies.
        # Available packages: containers, algebra, array, json, json-simple,
        # async, bytestring, hedgehog, parser, and 150+ more.
        idrisLibraries = with idris2-withpkgs.packages.${system}; [
          json
          # containers
          # algebra
          # array
          # bytestring
        ];

        # Wrapped idris2 with all selected packages available in devShell
        idris2Wrapped = idris2-withpkgs.lib.${system}.withPackages (p: [
          p.json
          # p.containers
          # p.algebra
        ]);

        pkg = pkgs.idris2Packages.buildIdris {
          src = ./.;
          ipkgName = "template";
          version = "0.1.0";
          inherit idrisLibraries;
        };
      in
      {
        packages = {
          default = pkg.executable;
          lib = pkg.library';
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            idris2Wrapped
            pkgs.rlwrap
            # idris2-mkdoc-md is available from the registry flake
            idris2-withpkgs.packages.${system}.idris2-mkdoc-md
          ];

          shellHook = ''
            echo "Idris2 project shell"
            echo ""
            echo "Build:"
            echo "  idris2 --build template.ipkg"
            echo "  ./build/exec/template"
            echo ""
            echo "Add dependencies:"
            echo "  1. Edit flake.nix, add to selectedLibs: p.containers p.algebra"
            echo "  2. Edit template.ipkg, add to depends: containers, algebra"
            echo "  3. Run: nix develop"
            echo ""
            echo "Generate docs:"
            echo "  idris2-mkdoc-md -o ./docs template.ipkg"
            echo ""
            echo "REPL with packages:"
            echo "  rlwrap idris2"
            echo ""
            echo "Available packages:"
            echo "  $(idris2 --list-packages | grep -v '^  ' | head -20 | tr '\n' ' ')"
          '';
        };
      }
    );
}
