# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-eff

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "eff";
  ipkg = "eff.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-eff";
    rev = "69f02c0209c2d92215557b73df76507933588a91";
    hash = "sha256-UIBcisBZCeov1YzuWt8OqHjra+wQ/aqfM5AUYpKlVpo=";  # hash-updated: 2026-06-19 16:28:02;  # hash-updated: 2026-05-02 03:08:10
  };
  deps = [ "freer" "tailrec" ];
}
