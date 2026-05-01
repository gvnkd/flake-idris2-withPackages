# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://gitlab.com/avidela/continuation-monad

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "continuation-monad";
  ipkg = "continuation-monad.ipkg";
  src = pkgs.fetchFromGitLab {
    owner = "avidela";
    repo = "continuation-monad";
    rev = "main";
    hash = "sha256-u44dUVs4juN/UXd7PZe6gVjQGNGaDWz/tMMRxsONANw=";  # hash-updated: 2026-05-02 03:07:51
  };
  deps = [ ];
}
