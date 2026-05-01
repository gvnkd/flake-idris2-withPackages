# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-indexed-graph

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "indexed-graph";
  ipkg = "indexed-graph.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-indexed-graph";
    rev = "main";
    hash = "sha256-YmPiYwb/lWp4nkyZrM5ERm7XqMNTyyZaTLknzR3axhg=";  # hash-updated: 2026-05-02 03:09:06
  };
  deps = [
    "array"
    "containers"
  ];
}
