# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/hash

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "hash";
  ipkg = "hash.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/hash";
    ref = "master";
    rev = "157a2737dd9b182015f01042f2cc61663660904d";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
}
