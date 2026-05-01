# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/racket-tcp

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "racket-tcp";
  ipkg = "racket-tcp.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/racket-tcp";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
