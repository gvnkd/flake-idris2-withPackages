# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kbertalan/idris2-node

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "node";
  ipkg = "node.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kbertalan";
    repo = "idris2-node";
    rev = "main";
    hash = "sha256-l9t9YgElcs6N//Bthko9tEiQ1BwopFISnLQcqGhigNo=";  # hash-updated: 2026-05-02 03:09:23
  };
  deps = [ ];
}
