# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-collection-utils

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "collection-utils";
  ipkg = "collection-utils.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-collection-utils";
    rev = "master";
    hash = "sha256-VxprrHyYyAEjfdC6OYYg9FVRQmesfEYt30OMUE1IRY4=";  # hash-updated: 2026-05-02 03:07:47
  };
  deps = [
    "best-alternative"
    "dependent-vect"
    "i-hate-parens"
    "fin-lizzie"
  ];
}
