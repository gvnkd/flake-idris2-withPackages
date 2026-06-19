# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-positive-nat

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "positive-nat";
  ipkg = "positive-nat.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-positive-nat";
    rev = "6f0858bc2158059231110babd02fa40b6ea3ff21";
    hash = "sha256-VVVYM9sd7SOyAvAPtjuIDMabjIiatDBMDpIO7neQKhY=";  # hash-updated: 2026-06-19 16:29:13;  # hash-updated: 2026-05-02 03:09:31
  };
  deps = [ "typelevel-emptiness-collections" ];
}
