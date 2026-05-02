# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/web-server-racket

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "web-server-racket";
  ipkg = "web-server-racket.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/web-server-racket";
    ref = "master";
    rev = "0d67bc5ef7c0ae112d6a61dbd011944cdfb15ccc";
    allRefs = true;
  };
  deps = [ "array" "http2" "pg" "racket-tcp" "utf8" ];
}
