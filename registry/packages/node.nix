# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kbertalan/idris2-node

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "node";
  ipkg = "node.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kbertalan";
    repo = "idris2-node";
    rev = "fb80b36c76b4332259033beadbd2cd35aafe64d0";
    hash = "sha256-l9t9YgElcs6N//Bthko9tEiQ1BwopFISnLQcqGhigNo=";  # hash-updated: 2026-06-19 16:29:03;  # hash-updated: 2026-05-02 03:09:23
  };
  deps = [ ];
}
