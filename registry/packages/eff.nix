# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-eff

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "eff";
  ipkg = "eff.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-eff";
    rev = "main";
    hash = "sha256-UIBcisBZCeov1YzuWt8OqHjra+wQ/aqfM5AUYpKlVpo=";  # hash-updated: 2026-05-02 03:08:10
  };
  deps = [ "freer" "tailrec" ];
}
