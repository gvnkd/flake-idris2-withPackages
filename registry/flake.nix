{
  description = "idris2-with-docs — Idris2 package registry with Markdown documentation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    idris2-src.url = "github:idris-lang/Idris2";
    idris2-src.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, idris2-src }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        idris2 = idris2-src.packages.${system}.idris2;
        idris2Api = idris2-src.packages.${system}.idris2Api;
        
        idris2-mkdoc-md = pkgs.stdenv.mkDerivation {
          pname = "idris2-mkdoc-md";
          version = "0.1.0";
          src = ../.;
          nativeBuildInputs = [ idris2 pkgs.makeWrapper ];
          buildInputs = [ idris2Api ];
          
          buildPhase = ''
            export IDRIS2_PACKAGE_PATH="${idris2}/idris2-${idris2.version}:${idris2Api}/lib/idris2-${idris2.version}''${IDRIS2_PACKAGE_PATH:+:$IDRIS2_PACKAGE_PATH}"
            idris2 --build idris2-mkdoc-md.ipkg
          '';
          
          installPhase = ''
            mkdir -p $out/bin
            cp -r build/exec/* $out/bin/
            for bin in $out/bin/*; do
              if [ -f "$bin" ] && [ -x "$bin" ]; then
                wrapProgram "$bin" \
                  --prefix IDRIS2_PACKAGE_PATH : "${idris2}/idris2-${idris2.version}:${idris2Api}/lib/idris2-${idris2.version}"
              fi
            done
          '';
        };
        
        pkgDb = import ./packages.nix { inherit pkgs idris2 idris2-mkdoc-md; };

        libPkgs = builtins.mapAttrs (name: pkg: pkg.libPkg) pkgDb.libs;
        docPkgs = pkgs.lib.mapAttrs' (name: value: { name = "${name}-docs"; inherit value; })
          (builtins.mapAttrs (name: pkg: pkg.docs) pkgDb.libs);

      in
      {
        packages = {
          inherit idris2-mkdoc-md;
        } // libPkgs // docPkgs;

        devShells.default = pkgs.mkShell {
          buildInputs = [ idris2 ] ++ (builtins.attrValues libPkgs);
        };
      }
    );
}
