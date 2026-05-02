# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/http2

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "http2";
  ipkg = "http2.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/http2";
    ref = "master";
    rev = "ce3e72a7843c6c42b7b30d62699b675001fa1e6c";
    allRefs = true;
  };
  deps = [ "array" "buf-conn" "cont" "pg-types" "utf8" ];
}
