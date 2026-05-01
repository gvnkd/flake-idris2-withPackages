# Algebraic data types
# Source: https://gitlab.com/avidela/algebraic-data

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "algdata";
  ipkg = "algdata.ipkg";
  src = pkgs.fetchFromGitLab {
    owner = "avidela";
    repo = "algebraic-data";
    rev = "main";
    hash = "sha256-b2ofl4FdcUXa2PpiSKtYHsLLDsdq5d1i/j2/TSX6zP0=";
  };
}
