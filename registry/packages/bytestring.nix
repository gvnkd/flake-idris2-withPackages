# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-bytestring

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "bytestring";
  ipkg = "bytestring.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-bytestring";
    rev = "main";
    hash = "sha256-kq8uYI5STgxJ7g1EgjaG7FGfZQ85qxBRm/bb6gI/hbk=";  # hash-updated: 2026-05-02 03:07:45
  };
  deps = [
    "algebra"
    "array"
  ];
}
