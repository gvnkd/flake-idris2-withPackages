# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-collection-utils

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "collection-utils";
  ipkg = "collection-utils.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-collection-utils";
    rev = "6df30b19c55233939065129b1c488f4aa4cdf60f";
    hash = "sha256-VxprrHyYyAEjfdC6OYYg9FVRQmesfEYt30OMUE1IRY4=";  # hash-updated: 2026-06-19 16:27:28;  # hash-updated: 2026-05-02 03:07:47
  };
  deps = [ "best-alternative" "dependent-vect" "fin-lizzie" "i-hate-parens" ];
}
