# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Matthew-Mosior/idris2-fixed

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "fixed";
  ipkg = "fixed.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Matthew-Mosior";
    repo = "idris2-fixed";
    rev = "main";
    hash = "sha256-UcYTBgLexPK5eaMwG9mfoGCpdJ7xVCJTVjQ0JoWY5Gs=";  # hash-updated: 2026-05-02 03:08:17
  };
  deps = [ ];
}
