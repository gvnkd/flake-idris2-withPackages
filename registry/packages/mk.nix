# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-mk

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "mk";
  ipkg = "mk.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-mk";
    rev = "0df0651b12ecc574d5083a361333f80aaaa912ad";
    hash = "sha256-GwgdbLc6+iPjU4T7h8/SJIaNoEq7fQQK1wrs1xv53sY=";  # hash-updated: 2026-06-19 16:28:54;  # hash-updated: 2026-05-02 03:09:17
  };
  deps = [ ];
}
