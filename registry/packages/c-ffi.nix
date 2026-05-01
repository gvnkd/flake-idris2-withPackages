# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://codeberg.org/joelberkeley/c-ffi

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "c-ffi";
  ipkg = "c-ffi.ipkg";
  src = builtins.fetchGit {
    url = "https://codeberg.org/joelberkeley/c-ffi";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
