# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/uartman/hashable-derive

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "hashable-derive";
  ipkg = "hashable-derive.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "uartman";
    repo = "hashable-derive";
    rev = "37a80fec1c72b7cbdb5a6e182f84899f34bcd1bd";
    hash = "sha256-/6qp+K7EYbKnwVB/J6ebWIX0p8xshiSN1pbEbaBsr6U=";  # hash-updated: 2026-06-19 16:28:25;  # hash-updated: 2026-05-02 03:08:25
  };
  deps = [ "elab-util" "hashable" "mk" ];
}
