# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Z-snails/Idris2-hashable

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "hashable";
  ipkg = "hashable.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Z-snails";
    repo = "Idris2-hashable";
    rev = "main";
    hash = "sha256-FO5sxlEJFIiNrluCrIH9ORFTUgldhbbG8C/r+pSD8T0=";  # hash-updated: 2026-05-02 03:09:02
  };
  deps = [ ];
}
