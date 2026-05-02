# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/sha

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "sha";
  ipkg = "sha.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/sha";
    ref = "master";
    rev = "24a0a37332a97187e9e1bf923a0465b58f07a1a4";
    allRefs = true;
  };
  deps = [ "hash" ];  # TODO: Add Idris dependencies
}
