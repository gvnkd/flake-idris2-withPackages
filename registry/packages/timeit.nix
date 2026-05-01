# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/MarcelineVQ/idris2-timeit

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "timeit";
  ipkg = "timeit.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "MarcelineVQ";
    repo = "idris2-timeit";
    rev = "main";
    hash = "sha256-Dlc5H3Ce0ewMOAUd4DVHPHd8mC8WPowKTw8FVbpMSR0=";  # hash-updated: 2026-05-02 03:10:05
  };
  deps = [ ];
}
