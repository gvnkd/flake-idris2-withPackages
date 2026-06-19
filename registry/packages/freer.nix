# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-freer

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "freer";
  ipkg = "freer.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-freer";
    rev = "180e2066f8c20b4f2197ae46fdb5c09a4fcb9ed2";
    hash = "sha256-uKnZcl4hoIjyILpx4TBn6GEQkHv15ySqYgyS9R12Iks=";  # hash-updated: 2026-06-19 16:28:18;  # hash-updated: 2026-05-02 03:08:20
  };
  deps = [ "tailrec" ];
}
