# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/victoredwardocallaghan/idris2-rtlsdr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "rtlsdr";
  ipkg = "rtlsdr.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "victoredwardocallaghan";
    repo = "idris2-rtlsdr";
    rev = "master";
    hash = "sha256-DuZ1AefaluxcdinUHdtu431jCmTscuTgSCRzTz+iIes=";  # hash-updated: 2026-05-02 03:09:49
  };
  deps = [ ];
}
