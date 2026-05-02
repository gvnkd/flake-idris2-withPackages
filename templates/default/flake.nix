{
  description = "Idris2 project template";

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
        
        idrisLibraries = [
          idris2-withpkgs.packages.${system}.json-simple
        ];
        
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
            idris2
            pkgs.rlwrap
          ];

          shellHook = ''
            echo "Idris2 project shell"
            echo "  Build: idris2 --build template.ipkg"
            echo "  Run:   ./build/exec/template"
            echo ""
            echo "To add more registry dependencies, edit flake.nix and add to idrisLibraries:"
            echo "  inherit (idris2-withpkgs.packages.\${system}) containers json;"
          '';
        };
      }
    );
}
