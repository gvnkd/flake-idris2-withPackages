# Elaboration utilities
# Source: https://github.com/stefan-hoeck/idris2-elab-util

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "elab-util";
  ipkg = "elab-util.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-elab-util";
    rev = "main";
    hash = "sha256-gCEJ+tpzM/i2rKABCsyYa3WBb089regWgM84XCSfUiw=";
  };
}
