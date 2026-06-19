# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-elab-util

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-elab-util";
    rev = "90a2363256cbaafd3b0cc4e2bf36003761b6c4f0";
    hash = "sha256-gCEJ+tpzM/i2rKABCsyYa3WBb089regWgM84XCSfUiw=";  # hash-updated: 2026-06-19 16:28:03;  # hash-updated: 2026-05-02 03:08:11
  };
in
{
  elab-pretty = buildIdrisWithDocs {
    pname = "elab-pretty";
    ipkg = "elab-pretty.ipkg";
    inherit src;
  deps = [ "elab-util" "prettier" ];
  };
  elab-util = buildIdrisWithDocs {
    pname = "elab-util";
    ipkg = "elab-util.ipkg";
    inherit src;
    deps = [ ];
  };
}
