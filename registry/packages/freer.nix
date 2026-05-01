# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-freer

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "freer";
  ipkg = "freer.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-freer";
    rev = "main";
    hash = "sha256-uKnZcl4hoIjyILpx4TBn6GEQkHv15ySqYgyS9R12Iks=";  # hash-updated: 2026-05-02 03:08:20
  };
  deps = [
    "tailrec"
  ];
}
