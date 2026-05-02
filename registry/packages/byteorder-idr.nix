# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~stygianentity/byteorder-idr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "byteorder";
  ipkg = "byteorder.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~stygianentity/byteorder-idr";
    ref = "trunk";
    rev = "8432cdd74a4129f95895586cbec203b15e89c91a";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
}
