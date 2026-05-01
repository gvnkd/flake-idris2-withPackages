# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://gitlab.com/avidela/algebraic-data

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "algdata";
  ipkg = "algdata.ipkg";
  src = pkgs.fetchFromGitLab {
    owner = "avidela";
    repo = "algebraic-data";
    rev = "main";
    hash = "sha256-b2ofl4FdcUXa2PpiSKtYHsLLDsdq5d1i/j2/TSX6zP0=";  # hash-updated: 2026-05-02 03:07:35
  };
  deps = [ ];
}
