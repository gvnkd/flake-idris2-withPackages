# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Z-snails/uniplate-idr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "uniplate";
  ipkg = "uniplate.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Z-snails";
    repo = "uniplate-idr";
    rev = "main";
    hash = "sha256-KpZVUY+f08HasE22gSq32azCoBFWJD+Yfz+PPEQAm7s=";  # hash-updated: 2026-05-02 03:10:12
  };
  deps = [ ];
}
