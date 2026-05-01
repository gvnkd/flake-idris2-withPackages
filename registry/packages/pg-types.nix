# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/pg-types

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "pg-types";
  ipkg = "pg-types.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/pg-types";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
