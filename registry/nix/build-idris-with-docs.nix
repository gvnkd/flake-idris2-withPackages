{ pkgs, idris2, idris2-mkdoc-md }:
let
  idrisVersion = idris2.version;
  idrName = "idris2-${idrisVersion}";
  libSuffix = "lib/${idrName}";

  # Collect all transitive Idris dependencies
  collectAllDeps = deps:
    let
      collect = seen: queue:
        if queue == [ ] then seen
        else let
          d = builtins.head queue;
          dName = if builtins.isString d then d else d.pname or (builtins.baseNameOf d);
          # deps will be looked up from the final libs set passed at call time
          newSeen = if builtins.elem dName seen.seen 
            then seen 
            else { 
              seen = seen.seen ++ [dName]; 
              derivations = seen.derivations ++ [ dName ];
            };
          newQueue = if builtins.elem dName seen.seen
            then builtins.tail queue
            else (builtins.tail queue);
        in collect newSeen newQueue;
    in (collect { seen = [ ]; derivations = [ ]; } deps).derivations;
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
  
  # Collect transitive dependencies
  allDepNames = collectAllDeps deps;
  allDepLibs = map (n: allLibs.${n} or (throw "Unknown transitive dependency '${n}' for package '${pname}'")) allDepNames;
  allDepDerivations = map (d: d.libPkg or d) allDepLibs;
  
  depPaths = pkgs.lib.makeSearchPath libSuffix allDepDerivations;
  fullPath = "${depPaths}:${idris2}/${idrName}";
  idrisLibraries = allDepDerivations;
  
  # Pass through extra attrs (patches, CFLAGS, etc.) to buildIdris
  extraAttrs = builtins.removeAttrs attrs [ "pname" "ipkg" "src" "deps" "cDeps" "nativeBuildInputs" ];

  # If the ipkg is in a subdirectory, we need to cd into it during build
  # because nixpkgs buildIdris expects the ipkg at the source root.
  # The directory change persists through subsequent phases.
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
