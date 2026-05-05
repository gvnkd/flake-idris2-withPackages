{
  description = "idris2-mkdoc-md — Markdown documentation generator for Idris2 packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    idris2-src.url = "github:idris-lang/Idris2";
    idris2-src.inputs.nixpkgs.follows = "nixpkgs";
    idris2-pack-db.url = "github:stefan-hoeck/idris2-pack-db";
    idris2-pack-db.flake = false;
  };

  outputs =
    { self, nixpkgs, flake-utils, idris2-src, idris2-pack-db }:
    let
      systemOutputs = flake-utils.lib.eachDefaultSystem (
        system:
        let
        pkgs = nixpkgs.legacyPackages.${system};
        headToml = "${idris2-pack-db}/collections/HEAD.toml";
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

            # Wrap to set IDRIS2_PACKAGE_PATH, LD_LIBRARY_PATH, and IDRIS2_LIBS at runtime
            for bin in $out/bin/*; do
              if [ -f "$bin" ] && [ -x "$bin" ]; then
                wrapProgram "$bin" \
                  --prefix IDRIS2_PACKAGE_PATH : "${idris2}/${idrName}:${idris2Api}/${libSuffix}" \
                  --prefix LD_LIBRARY_PATH : "${idris2Api}/lib" \
                  --prefix IDRIS2_LIBS : "${idris2Api}/lib"
              fi
            done
          '';
        };

        # Build-system timeline. Bump when changing the build procedure
        # to force rebuild of all packages that use this builder.
        timeline = 4;

        # Wrapper around nixpkgs buildIdris that adds docs generation
        buildIdrisWithDocs =
          { src
          , ipkgName
          , version ? "t${toString timeline}"
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
            # Also copy FFI shared libraries (.so, .dylib) created by preinstall hooks
            # to $out/lib so downstream packages can find them via LD_LIBRARY_PATH
            libPkg = pkgs.lib.fix (self:
              (basePkg.library { withSource = true; }).overrideAttrs (old: {
                postInstall = ''
                  ${old.postInstall or ""}
                  # Copy FFI shared libraries to $out/lib for runtime linking.
                  # Search both current directory and parent (some .ipkg preinstall
                  # hooks write to ../lib relative to their subdirectory).
                  mkdir -p $out/lib
                  for dir in . ..; do
                    if [ -d "$dir" ]; then
                      find "$dir" -maxdepth 2 -type f \( -name '*.so' -o -name '*.dylib' -o -name '*.dll' \) -exec cp {} $out/lib/ \; 2>/dev/null || true
                    fi
                  done
                '';
                passthru = old.passthru // {
                  # Ensure downstream buildIdris calls get the overridden version
                  # (buildIdris uses lib.withSource for propagatedIdrisLibraries)
                  withSource = self;
                };
              })
            );
            
            # Collect all transitive dependencies
            allDeps = pkgs.lib.unique (
              pkgs.lib.concatMap (
                d: [ d ] ++ (d.propagatedIdrisLibraries or [ ])
              ) (libPkg.propagatedIdrisLibraries or [ ])
            );
            
            # Build IDRIS2_PACKAGE_PATH for docs generation
            depPaths = pkgs.lib.makeSearchPath libSuffix allDeps;
            fullPath = "${depPaths}:${idris2}/${idrName}";
            
            # Build LD_LIBRARY_PATH for FFI shared objects
            libDirs = pkgs.lib.makeSearchPath "lib" allDeps;
            
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
            # Expose the executable derivation (will only build successfully if
            # the ipkg defines a `main` / `executable`)
            executable = basePkg.executable;
            
            docs = pkgs.stdenv.mkDerivation (docPatchAttrs // {
              name = "${ipkgName}-docs";
              inherit src version;
              
              nativeBuildInputs = [ idris2 idris2-mkdoc-md ] ++ nativeBuildInputs;
              buildInputs = allDeps ++ buildInputs;
              
              buildPhase = ''
                runHook preBuild
                export IDRIS2_PACKAGE_PATH="${fullPath}"
                export LD_LIBRARY_PATH="${libDirs}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
                export IDRIS2_LIBS="${libDirs}''${IDRIS2_LIBS:+:$IDRIS2_LIBS}"
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

        # Script to regenerate registry packages from upstream HEAD.toml
        generate-registry = pkgs.writeShellScriptBin "generate-registry" ''
          set -euo pipefail

          # Find the project root (directory containing flake.nix)
          if [ -f "flake.nix" ]; then
            PROJECT_ROOT="$(pwd)"
          elif [ -f "../flake.nix" ]; then
            PROJECT_ROOT="$(cd .. && pwd)"
          elif git rev-parse --show-toplevel 2>/dev/null; then
            PROJECT_ROOT="$(git rev-parse --show-toplevel)"
          else
            echo "Error: Cannot find project root (flake.nix). Please run from the project directory."
            exit 1
          fi

          cd "$PROJECT_ROOT"
          echo "Generating registry packages from ${headToml}..."
          ${pkgs.python3}/bin/python3 \
            ${./registry/scripts/generate-from-head.py} \
            "${headToml}" \
            "$PROJECT_ROOT/registry/packages"
          echo ""
          echo "Done! Next steps:"
          echo "  1. Run ./registry/scripts/update-hashes.sh  (for GitHub/GitLab packages)"
          echo "  2. Run ./registry/scripts/pin-fetchgit-revs.sh  (for git.sr.ht / codeberg packages)"
          echo "  3. Review and fix deps = [ ] in generated files"
        '';

        # Import registry packages
        pkgDb = import ./registry/packages.nix { inherit pkgs idris2 idris2-mkdoc-md; idris2api = idris2Api; };
        registryPkgs = pkgs.lib.filterAttrs (n: v: builtins.isAttrs v && v ? libPkg) pkgDb.libs;
        registryLibPkgs = builtins.mapAttrs (name: pkg: pkg.libPkg) registryPkgs;
        registryDocPkgs = builtins.mapAttrs (name: pkg: pkg.docs)
          (pkgs.lib.mapAttrs' (name: pkg: pkgs.lib.nameValuePair "${name}-docs" pkg) registryPkgs);

        # Propagate all transitive dependencies like nixpkgs buildIdris does
        propagateLibs = libs: pkgs.lib.unique (
          pkgs.lib.concatMap (
            nextLib: [ nextLib ] ++ (nextLib.propagatedIdrisLibraries or [ ])
          ) libs
        );

        # Standalone doc browser tool (use DOCS_PATH env var or pass path as arg)
        doc-browser = pkgs.runCommand "doc-browser" {} ''
          mkdir -p $out/bin
          cp ${./scripts/doc-browser} $out/bin/doc-browser
          chmod +x $out/bin/doc-browser
        '';

        # Create docs + browser bundles for each package
        docsWithBrowser = builtins.mapAttrs (name: pkg:
          let
            pkgDocsPath = "${pkg.docs}/share/doc/${name}";
          in
          pkgs.symlinkJoin {
            name = "${name}-docs-with-browser";
            paths = [ doc-browser ];
            buildInputs = [ pkgs.makeWrapper ];
            postBuild = ''
              # Wrap doc-browser with this package's docs path
              wrapProgram $out/bin/doc-browser \
                --set DOCS_PATH "${pkgDocsPath}"
              
              # Create alias
              ln -s $out/bin/doc-browser $out/bin/${name}-doc
              
              # Symlink the raw docs
              mkdir -p $out/share/doc
              ln -s ${pkg.docs}/share/doc/${name} $out/share/doc/${name}
            '';
          }
        ) registryPkgs;
        
        # Rename keys to avoid collision with lib packages
        docsWithBrowserNamed = builtins.mapAttrs
          (name: drv: drv)
          (pkgs.lib.mapAttrs'
            (name: pkg: pkgs.lib.nameValuePair "${name}-docs-with-browser"
              (docsWithBrowser.${name}))
            registryPkgs
          );

        # Curated subset of packages known to build successfully.
        # Used for the all-docs bundle to avoid fragile packages with
        # stale hashes or network issues.
        curatedPkgNames = [
          "algebra"
          "barbies"
          "bytestring"
          "containers"
          "dtypes"
          "eff"
          "elab-util"
          "filepath"
          "finite"
          "freer"
          "graph"
          "hashable"
          "indexed"
          "json"
          "parser"
          "pretty-show"
          "quantifiers-extra"
          "refined"
          "sop"
          "xml"
        ];
        curatedPkgs = pkgs.lib.genAttrs curatedPkgNames (name: registryPkgs.${name});

        # Bundle curated package docs into a single collection directory
        all-docs = pkgs.runCommand "all-docs" {
          nativeBuildInputs = [ pkgs.makeWrapper ];
        } (
          let
            linkCommands = pkgs.lib.mapAttrsToList (name: pkg: ''
              if [ -d ${pkg.docs}/share/doc ]; then
                for dir in ${pkg.docs}/share/doc/*; do
                  if [ -d "$dir" ]; then
                    ln -s "$dir" $out/share/doc/${name}
                  fi
                done
              fi
            '') curatedPkgs;
          in
          ''
            mkdir -p $out/share/doc
            ${pkgs.lib.concatStringsSep "\n" linkCommands}

            mkdir -p $out/bin
            cp ${doc-browser}/bin/doc-browser $out/bin/
            chmod +x $out/bin/doc-browser

            wrapProgram $out/bin/doc-browser \
              --set DOCS_PATH "$out/share/doc"
          ''
        );

      in
      {
        packages = {
          inherit idris2-mkdoc-md generate-registry doc-browser all-docs;
          idrisGL = idrisGL-pkg.libPkg;
          idrisGL-docs = idrisGL-pkg.docs;
          default = idris2-mkdoc-md;
        } // registryLibPkgs // registryDocPkgs // docsWithBrowserNamed // {
          # Custom package executables (override libPkg entries)
          fmt = registryPkgs.fmt.executable;
          taiga-cli = registryPkgs.taiga-cli.executable;
          optparse-applicative-example = registryPkgs.optparse-applicative-example.executable;
        };

        lib = {
          withPackages = selector:
            let
              selectedLibs = propagateLibs (selector registryLibPkgs);
              libPaths = pkgs.lib.makeSearchPath libSuffix selectedLibs;
              fullPackagePath = "${libPaths}:${idris2}/${idrName}";
              # Collect lib/ directories for LD_LIBRARY_PATH and IDRIS2_LIBS
              # so that FFI shared objects from dependencies can be found
              libDirs = pkgs.lib.makeSearchPath "lib" selectedLibs;
            in
            pkgs.symlinkJoin {
              name = "idris2-with-packages";
              paths = [ idris2 ] ++ selectedLibs;
              buildInputs = [ pkgs.makeWrapper ];
              postBuild = ''
                wrapProgram $out/bin/idris2 \
                  --suffix IDRIS2_PACKAGE_PATH ':' "${fullPackagePath}" \
                  --suffix LD_LIBRARY_PATH ':' "${libDirs}" \
                  --suffix IDRIS2_LIBS ':' "${libDirs}"
              '';
            };
        };

        devShells.default = pkgs.mkShell {
          buildInputs = [
            idris2
            pkgs.rlwrap
            idris2-mkdoc-md
            generate-registry
          ];

          shellHook = ''
            export IDRIS2_PACKAGE_PATH="${idris2}/${idrName}:${idris2Api}/${libSuffix}''${IDRIS2_PACKAGE_PATH:+:$IDRIS2_PACKAGE_PATH}"
            export LD_LIBRARY_PATH="${idris2Api}/lib''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
            export IDRIS2_LIBS="${idris2Api}/lib''${IDRIS2_LIBS:+:$IDRIS2_LIBS}"
            echo "Available commands:"
            echo "  generate-registry  - Regenerate packages from upstream idris2-pack-db"
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
