# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/utf8

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "utf8";
  ipkg = "utf8.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/utf8";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
