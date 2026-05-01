# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/pg

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "pg";
  ipkg = "pg.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/pg";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
