# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~stygianentity/byteorder-idr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "byteorder";
  ipkg = "byteorder.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~stygianentity/byteorder-idr";
    ref = "trunk";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
