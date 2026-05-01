# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/http2

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "http2";
  ipkg = "http2.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/http2";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
