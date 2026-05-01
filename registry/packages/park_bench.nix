# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Z-snails/park_bench

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "park_bench";
  ipkg = "park_bench.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Z-snails";
    repo = "park_bench";
    rev = "main";
    hash = "sha256-nADtYBrHK2P281Fx2k0myvS0TgG1DRnWvfDtgjR1s+Q=";  # hash-updated: 2026-05-02 03:09:28
  };
  deps = [ ];
}
