# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-positive-nat

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "positive-nat";
  ipkg = "positive-nat.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-positive-nat";
    rev = "master";
    hash = "sha256-VVVYM9sd7SOyAvAPtjuIDMabjIiatDBMDpIO7neQKhY=";  # hash-updated: 2026-05-02 03:09:31
  };
  deps = [ "typelevel-emptiness-collections" ];
}
