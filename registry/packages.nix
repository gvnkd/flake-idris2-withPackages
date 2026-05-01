{ pkgs, idris2, idris2-mkdoc-md }:
let
  # Read all .nix files in packages/
  packageFiles = builtins.attrNames (builtins.readDir ./packages);
  nixFiles = builtins.filter (name: pkgs.lib.hasSuffix ".nix" name) packageFiles;
  
  # Import the build helper - it takes allLibs as a parameter
  mkBuildIdrisWithDocs = allLibs:
    import ./nix/build-idris-with-docs.nix { inherit pkgs idris2 idris2-mkdoc-md; } { inherit allLibs; };
  
  # Create a recursive set of all libraries.
  # Each package file is imported with (pkgs, buildIdrisWithDocs) where
  # buildIdrisWithDocs is a function that already has allLibs resolved.
  libs = pkgs.lib.fix (self:
    let
      buildIdrisWithDocs = mkBuildIdrisWithDocs self;
      
      # Import each file and flatten results
      importPackageFile = file:
        let
          name = pkgs.lib.removeSuffix ".nix" file;
          result = import ./packages/${file} { inherit pkgs buildIdrisWithDocs; };
        in
          # A file can return either a single package or an attrset of packages
          if builtins.isAttrs result && result ? libPkg
            then { ${name} = result; }
            else result;
      
      allPackages = builtins.foldl' (acc: file: acc // (importPackageFile file)) {} nixFiles;
    in
      allPackages
  );
in
{
  inherit libs;
  activePackageNames = builtins.attrNames libs;
}
