# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/string-search

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "string-search";
  ipkg = "string-search.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/string-search";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
