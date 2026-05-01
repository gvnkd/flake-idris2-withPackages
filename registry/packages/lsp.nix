# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/idris2-lsp

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "idris2-lsp";
  ipkg = "idris2-lsp.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-lsp";
    rev = "main";
    hash = "sha256-N6ojdGSoqQ+AIAbriRtl01lhHqXlEylKLiTEbmUt4uE=";  # hash-updated: 2026-05-02 03:09:16
  };
  deps = [
    "lsp-lib"
  ];
}
