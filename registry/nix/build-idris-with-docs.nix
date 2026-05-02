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

  # Resolve dependency names to actual derivations
  resolveDep = name:
    if builtins.isString name
      then allLibs.${name} or (throw "Unknown dependency '${name}' for package '${pname}'")
      else name;

  resolvedDeps = map resolveDep deps;
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
      ${if ipkgDir != "." then "cd ${ipkgDir}" else ""}
      ${idris2-mkdoc-md}/bin/idris2-mkdoc-md -o ./docs ${ipkgName}.ipkg
      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/doc/${pname}
      cp -r ./docs/* $out/share/doc/${pname}/
      runHook postInstall
    '';
  });
}
