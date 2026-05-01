# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-filepath

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "filepath";
  ipkg = "filepath.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-filepath";
    rev = "main";
    hash = "sha256-aEKa3mtqKirxqHmsOal/14oSv+PoMj3TvLEKhhpfqAY=";  # hash-updated: 2026-05-02 03:08:15
  };
  deps = [ ];
}
