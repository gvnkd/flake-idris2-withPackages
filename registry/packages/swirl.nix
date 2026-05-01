# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-swirl

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "swirl";
  ipkg = "swirl.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-swirl";
    rev = "master";
    hash = "sha256-zzyIVWwgh3bKHNySlGqr/TK4uUrRjxqmGeIY5kzwYdM=";  # hash-updated: 2026-05-02 03:09:58
  };
  deps = [
    "if-unsolved-implicit"
    "tailrec"
  ];
}
