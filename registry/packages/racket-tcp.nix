# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/racket-tcp

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "racket-tcp";
  ipkg = "racket-tcp.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/racket-tcp";
    ref = "master";
    rev = "1fb135821a0fad9770393473e1dc4dee0d26e1e5";
    allRefs = true;
  };
  deps = [ ];
}
