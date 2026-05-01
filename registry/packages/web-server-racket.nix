# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/web-server-racket

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "web-server-racket";
  ipkg = "web-server-racket.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/web-server-racket";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
