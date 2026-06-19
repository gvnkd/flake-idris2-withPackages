# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-swirl

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "swirl";
  ipkg = "swirl.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-swirl";
    rev = "6fee6df50cf3c369e80bca06372a81687bf6b248";
    hash = "sha256-zzyIVWwgh3bKHNySlGqr/TK4uUrRjxqmGeIY5kzwYdM=";  # hash-updated: 2026-06-19 16:29:52;  # hash-updated: 2026-05-02 03:09:58
  };
  deps = [ "if-unsolved-implicit" "tailrec" ];
}
