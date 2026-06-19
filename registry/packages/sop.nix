# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-sop

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "sop";
  ipkg = "sop.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-sop";
    rev = "1e01b67a11857e9c9a0ea5fb2870bd915b5a223d";
    hash = "sha256-rZcDly3l3PKY4jrUCSk1Lbdj++5N90KCZMaChlyzMGE=";  # hash-updated: 2026-06-19 16:29:42;  # hash-updated: 2026-05-02 03:09:51
  };
  deps = [ "elab-util" ];
}
