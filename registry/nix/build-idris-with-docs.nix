{ pkgs, idris2, idris2-mkdoc-md }:
let
  idrisVersion = idris2.version;
  idrName = "idris2-${idrisVersion}";
  libSuffix = "lib/${idrName}";
  # Timeline: bump this when changing the build procedure to force
  # rebuild of all registry packages.
  timeline = 4;
  packageVersion = "main-t${toString timeline}";
in
{ allLibs }:
{ pname
, ipkg
, src
, deps ? [ ]
, cDeps ? [ ]
, nativeBuildInputs ? [ ]
, ...
}@attrs:
let
  ipkgName = builtins.replaceStrings [".ipkg"] [""] (builtins.baseNameOf ipkg);
  ipkgDir = builtins.dirOf ipkg;

  # Built-in packages provided by the compiler itself
  builtinPackages = [ "base" "prelude" "contrib" "linear" "network" "test" "idris2" "idris2api" "template-idris" ];

  # Resolve dependency names to actual derivations
  resolveDep = name:
    if builtins.isString name
      then
        if builtins.elem name builtinPackages
          then null
          else if builtins.hasAttr name allLibs
            then allLibs.${name}
            else null  # Skip unknown dependencies (package may still build if they're optional)
      else name;

  resolvedDeps = builtins.filter (d: d != null) (map resolveDep deps);
  idrisLibraries = map (d: d.libPkg or d) resolvedDeps;

  # Pass through extra attrs (patches, CFLAGS, etc.) to buildIdris
  extraAttrs = builtins.removeAttrs attrs [ "pname" "ipkg" "src" "deps" "cDeps" "nativeBuildInputs" ];

  subdirFix = if ipkgDir != "." then {
    preBuild = "cd ${ipkgDir}";
  } else {};

  basePkg = pkgs.idris2Packages.buildIdris (extraAttrs // subdirFix // {
    inherit src;
    ipkgName = pname;
    version = packageVersion;
    inherit idrisLibraries;
    nativeBuildInputs = nativeBuildInputs ++ cDeps;
    buildInputs = cDeps;
  });

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

  # For docs generation, use the already-resolved transitive deps from libPkg
  allDepDerivations = libPkg.propagatedIdrisLibraries or [ ];
  depPaths = pkgs.lib.makeSearchPath libSuffix allDepDerivations;
  fullPath = "${depPaths}:${idris2}/${idrName}";

  # Build LD_LIBRARY_PATH for FFI shared objects from dependencies
  libDirs = pkgs.lib.makeSearchPath "lib" allDepDerivations;

  docPatchAttrs = pkgs.lib.intersectAttrs {
    postPatch = true; prePatch = true; patches = true;
    NIX_CFLAGS_COMPILE = true; CFLAGS = true; LDFLAGS = true; PKG_CONFIG_PATH = true;
  } attrs;
in
{
  inherit libPkg deps;
  pname = pname;

  docs = pkgs.stdenv.mkDerivation (docPatchAttrs // {
    name = "${pname}-docs";
    inherit src;
    version = packageVersion;
    nativeBuildInputs = [ idris2 idris2-mkdoc-md ] ++ nativeBuildInputs ++ cDeps;
    buildInputs = allDepDerivations ++ cDeps;

    buildPhase = ''
      runHook preBuild
      export IDRIS2_PACKAGE_PATH="${fullPath}"
      export LD_LIBRARY_PATH="${libDirs}''${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      export IDRIS2_LIBS="${libDirs}''${IDRIS2_LIBS:+:$IDRIS2_LIBS}"
      ${if ipkgDir != "." then "cd ${ipkgDir}" else ""}
      ${idris2-mkdoc-md}/bin/idris2-mkdoc-md -o ./docs ${ipkgName}.ipkg
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/doc/${pname}
      # Use -L to follow symlinks (prevents broken symlinks in store)
      cp -rL ./docs/* $out/share/doc/${pname}/
      runHook postInstall
    '';
  });
}
