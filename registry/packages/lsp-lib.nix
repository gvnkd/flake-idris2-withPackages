# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/lsp-lib

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "lsp-lib";
  ipkg = "lsp-lib.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "lsp-lib";
    rev = "ca77e80a392b8cfeee3aaeb150069957699cdb82";
    hash = "sha256-maXHx/OrflIdV7XPfDCRShUGZekLbLOSFQPHnL6DxnI=";  # hash-updated: 2026-06-19 16:28:51;  # hash-updated: 2026-05-02 03:09:15
  };
  deps = [ ];
}
