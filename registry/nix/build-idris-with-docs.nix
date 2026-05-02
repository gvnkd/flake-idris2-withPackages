{ pkgs, idris2, idris2-mkdoc-md }:
let
  idrisVersion = idris2.version;
  idrName = "idris2-${idrisVersion}";
  libSuffix = "lib/${idrName}";
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
    version = "main";
    inherit idrisLibraries;
    nativeBuildInputs = nativeBuildInputs ++ cDeps;
    buildInputs = cDeps;
  });

  libPkg = basePkg.library { withSource = true; };

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
    version = "main";
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
