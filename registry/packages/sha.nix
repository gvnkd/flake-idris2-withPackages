# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/sha

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "sha";
  ipkg = "sha.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/sha";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
