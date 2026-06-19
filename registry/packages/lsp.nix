# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/idris2-lsp

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "idris2-lsp";
  ipkg = "idris2-lsp.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-lsp";
    rev = "fb6f798fb71cde07f02bf901f9fbb2b4112aa108";
    hash = "sha256-ma7b54o69v8cWTG1Ma8tre5tjFFZ6FZF8eF6GEuGEDI=";  # hash-updated: 2026-06-19 16:28:53;  # hash-updated: 2026-05-02 03:09:16
  };
  deps = [ "idris2" "lsp-lib" ];
}
