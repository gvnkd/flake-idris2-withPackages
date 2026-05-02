# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/string-search

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "string-search";
  ipkg = "string-search.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/string-search";
    ref = "master";
    rev = "96b3ba239f8bb7b2cf11b6078efde10057b5821a";
    allRefs = true;
  };
  deps = [ ];
}
