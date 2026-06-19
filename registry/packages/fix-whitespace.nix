# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris-fix-whitespace

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "fix-whitespace";
  ipkg = "fix-whitespace.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris-fix-whitespace";
    rev = "ec8d82a88cc12a787e0c81b9ce4d85d90f6291ee";
    hash = "sha256-ZrEui7CxcXiQFSMvB2aTBnI+UWKxxhUHKtEV76ai2fQ=";  # hash-updated: 2026-06-19 16:28:14;  # hash-updated: 2026-05-02 03:08:18
  };
  deps = [ "elab-pretty" "elab-util" "filepath" "getopts" ];
}
