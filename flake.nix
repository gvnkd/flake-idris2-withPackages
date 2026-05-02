{
  description = "idris2-mkdoc-md — Markdown documentation generator for Idris2 packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    idris2-src.url = "github:idris-lang/Idris2";
    idris2-src.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { self, nixpkgs, flake-utils, idris2-src }:
    let
      systemOutputs = flake-utils.lib.eachDefaultSystem (
        system:
        let
        pkgs = nixpkgs.legacyPackages.${system};
        idris2 = idris2-src.packages.${system}.idris2;
        idris2Api = idris2-src.packages.${system}.idris2Api;
        idrisVersion = idris2.version;
        idrName = "idris2-${idrisVersion}";
        libSuffix = "lib/${idrName}";

        # Build idris2-mkdoc-md executable
        idris2-mkdoc-md = pkgs.stdenv.mkDerivation {
          pname = "idris2-mkdoc-md";
          version = "0.1.0";
          src = ./.;
          nativeBuildInputs = [ idris2 pkgs.makeWrapper ];
          buildInputs = [ idris2Api ];
          
          buildPhase = ''
            export IDRIS2_PACKAGE_PATH="${idris2}/${idrName}:${idris2Api}/${libSuffix}''${IDRIS2_PACKAGE_PATH:+:$IDRIS2_PACKAGE_PATH}"
            idris2 --build idris2-mkdoc-md.ipkg
          '';
          
          installPhase = ''
            mkdir -p $out/bin
            cp -r build/exec/* $out/bin/
            
            # Wrap to set IDRIS2_PACKAGE_PATH at runtime
            for bin in $out/bin/*; do
              if [ -f "$bin" ] && [ -x "$bin" ]; then
                wrapProgram "$bin" \
                  --prefix IDRIS2_PACKAGE_PATH : "${idris2}/${idrName}:${idris2Api}/${libSuffix}"
              fi
            done
          '';
        };

        # Wrapper around nixpkgs buildIdris that adds docs generation
        buildIdrisWithDocs =
          { src
          , ipkgName
          , version ? "unversioned"
          , idrisLibraries ? [ ]
          , nativeBuildInputs ? [ ]
          , buildInputs ? [ ]
          , preBuild ? ""
          , ...
          }@attrs:
          let
            # Extra attrs to pass to buildIdris (excluding our custom ones)
            extraAttrs = builtins.removeAttrs attrs [ "idrisLibraries" ];
            
            # Use nixpkgs buildIdris for the library
            basePkg = pkgs.idris2Packages.buildIdris (extraAttrs // {
              inherit ipkgName version idrisLibraries;
            });
            
            # Get the library derivation (with source for docs)
            libPkg = basePkg.library { withSource = true; };
            
            # Collect all transitive dependencies
            allDeps = pkgs.lib.unique (
              pkgs.lib.concatMap (
                d: [ d ] ++ (d.propagatedIdrisLibraries or [ ])
              ) (libPkg.propagatedIdrisLibraries or [ ])
            );
            
            # Build IDRIS2_PACKAGE_PATH for docs generation
            depPaths = pkgs.lib.makeSearchPath libSuffix allDeps;
            fullPath = "${depPaths}:${idris2}/${idrName}";
            
            # Extract patch-related attrs for docs derivation
            docPatchAttrs = pkgs.lib.intersectAttrs {
              postPatch = true;
              prePatch = true;
              patches = true;
              NIX_CFLAGS_COMPILE = true;
              CFLAGS = true;
              LDFLAGS = true;
              PKG_CONFIG_PATH = true;
            } attrs;
          in
          {
            inherit libPkg;
            
            docs = pkgs.stdenv.mkDerivation (docPatchAttrs // {
              name = "${ipkgName}-docs";
              inherit src version;
              
              nativeBuildInputs = [ idris2 idris2-mkdoc-md ] ++ nativeBuildInputs;
              buildInputs = allDeps ++ buildInputs;
              
              buildPhase = ''
                runHook preBuild
                export IDRIS2_PACKAGE_PATH="${fullPath}"
                ${idris2-mkdoc-md}/bin/idris2-mkdoc-md -o ./docs ${ipkgName}.ipkg
                runHook postBuild
              '';
              
              installPhase = ''
                runHook preInstall
                mkdir -p $out/share/doc/${ipkgName}
                cp -r ./docs/* $out/share/doc/${ipkgName}/
                runHook postInstall
              '';
            });
          };

        # Test with idrisGL
        idrisGL-pkg = buildIdrisWithDocs {
          ipkgName = "idrisGL";
          version = "1.0.0";
          src = pkgs.fetchFromGitHub {
            owner = "ECburx";
            repo = "Idris2GL";
            rev = "44da0855bc8b2cfdf796ba9557e8c500395a8c41";
            hash = "sha256-N5xrWhDBNJMb7jOjuz5qaqqYgGPYn21I0ERtuZpc3Wo=";
          };
          nativeBuildInputs = with pkgs; [ gnumake pkg-config ];
          buildInputs = with pkgs; [ 
            SDL2 
            SDL2_image 
            SDL2_ttf 
            SDL2_gfx 
            SDL2_mixer 
          ];
          NIX_CFLAGS_COMPILE = [
            "-I${pkgs.SDL2.dev or pkgs.SDL2}/include"
            "-I${pkgs.SDL2.dev or pkgs.SDL2}/include/SDL2"
            "-I${pkgs.SDL2_gfx}/include/SDL2"
            "-I${pkgs.SDL2_image}/include/SDL2"
            "-I${pkgs.SDL2_ttf}/include/SDL2"
            "-I${pkgs.SDL2_mixer.dev or pkgs.SDL2_mixer}/include/SDL2"
          ];
          postPatch = ''
            # Fix Windows line endings
            ${pkgs.dos2unix}/bin/dos2unix src/c_src/Makefile
            
            # Patch Makefile to use pkg-config for proper library flags
            substituteInPlace src/c_src/Makefile \
              --replace-fail 'SDL_FLAG          := -lSDL2' \
                'SDL_FLAG          := $(shell pkg-config --libs sdl2)' \
              --replace-fail 'SDL_IMG_FLAG      := $(SDL_FLAG) -lSDL2_image' \
                'SDL_IMG_FLAG      := $(shell pkg-config --libs sdl2 SDL2_image)' \
              --replace-fail 'SDL_GFX_FLAG      := $(SDL_FLAG) -lSDL2_gfx' \
                'SDL_GFX_FLAG      := $(shell pkg-config --libs sdl2 SDL2_gfx)' \
              --replace-fail 'SDL_TTF_FLAG      := $(SDL_FLAG) -lSDL2_ttf' \
                'SDL_TTF_FLAG      := $(shell pkg-config --libs sdl2 SDL2_ttf)' \
              --replace-fail 'SDL_MIXER_FLAG    := $(SDL_FLAG) -lSDL2_mixer' \
                'SDL_MIXER_FLAG    := $(shell pkg-config --libs sdl2 SDL2_mixer)'
          '';
          dontUseCmakeConfigure = true;
          dontUseMesonConfigure = true;
        };

      in
      {
        packages = {
          inherit idris2-mkdoc-md;
          idrisGL = idrisGL-pkg.libPkg;
          idrisGL-docs = idrisGL-pkg.docs;
          default = idris2-mkdoc-md;
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            idris2
            pkgs.rlwrap
            idris2-mkdoc-md
          ];

          shellHook = ''
            export IDRIS2_PACKAGE_PATH="${idris2}/${idrName}:${idris2Api}/${libSuffix}''${IDRIS2_PACKAGE_PATH:+:$IDRIS2_PACKAGE_PATH}"
          '';
        };
      }
    );
    in
    systemOutputs // {
      templates.default = {
        path = ./templates/default;
        description = "Minimal Idris2 project with Nix flake support";
      };
    };
}
