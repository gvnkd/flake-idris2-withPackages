# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/uartman/hashable-derive

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "hashable-derive";
  ipkg = "hashable-derive.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "uartman";
    repo = "hashable-derive";
    rev = "main";
    hash = "sha256-/6qp+K7EYbKnwVB/J6ebWIX0p8xshiSN1pbEbaBsr6U=";  # hash-updated: 2026-05-02 03:08:25
  };
  deps = [ "elab-util" "hashable" "mk" ];
}
