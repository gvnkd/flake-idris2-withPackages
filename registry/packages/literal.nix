# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-literal

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "literal";
  ipkg = "literal.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-literal";
    rev = "main";
    hash = "sha256-9hSzw/opHByTMR1vbgL/jcvm1vinEcP/dKmexjZWNKc=";  # hash-updated: 2026-05-02 03:09:13
  };
  deps = [
    "elab-util"
    "refined"
  ];
}
