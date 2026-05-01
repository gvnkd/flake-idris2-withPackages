{
  description = "idris2-mkdoc-md — Markdown documentation generator for Idris2 packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    idris2-src.url = "github:idris-lang/Idris2";
    idris2-src.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      idris2-src,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        idris2 = idris2-src.packages.${system}.idris2;
        idris2Api = idris2-src.packages.${system}.idris2Api;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            idris2
            pkgs.rlwrap
          ];

          shellHook = ''
            export IDRIS2_PACKAGE_PATH="${idris2}/idris2-0.8.0:${idris2Api}/lib/idris2-0.8.0''${IDRIS2_PACKAGE_PATH:+:$IDRIS2_PACKAGE_PATH}"
          '';
        };
      }
    );
}
