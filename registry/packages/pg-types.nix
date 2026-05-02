# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/pg-types

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "pg-types";
  ipkg = "pg-types.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/pg-types";
    ref = "master";
    rev = "b854bbcfb5e9e303d836d9b5a733b0060eb9e90a";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
}
