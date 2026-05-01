# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/base64

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "base64";
  ipkg = "base64.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/base64";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
