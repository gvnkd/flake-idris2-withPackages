# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-cozippable

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "cozippable";
  ipkg = "cozippable.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-cozippable";
    rev = "157960afd73f8f30a9521f936945991dd8369a35";
    hash = "sha256-lC3f8LUk0zopSTBmeyfNWDN3oI3cQ95yyh24uvM4tAo=";  # hash-updated: 2026-06-19 16:27:38;  # hash-updated: 2026-05-02 03:07:54
  };
  deps = [ ];
}
