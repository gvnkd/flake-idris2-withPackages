# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/pg

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "pg";
  ipkg = "pg.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/pg";
    ref = "master";
    rev = "4d3d5546ead083ece2108d4089b50f1268cfdeee";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
}
