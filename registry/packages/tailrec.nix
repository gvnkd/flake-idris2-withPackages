# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-tailrec

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "tailrec";
  ipkg = "tailrec.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-tailrec";
    rev = "2734dfdac3dedafcc0140b5388af760d0729b62f";
    hash = "sha256-7u02JdLevzhtBFSucNhtzOjJeYvlE1ySMJ8E8teTHXE=";  # hash-updated: 2026-06-19 16:29:55;  # hash-updated: 2026-05-02 03:10:00
  };
  deps = [ ];
}
