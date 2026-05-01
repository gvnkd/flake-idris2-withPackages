# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-pretty-show

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "pretty-show";
  ipkg = "pretty-show.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-pretty-show";
    rev = "main";
    hash = "sha256-StgfV4cgLt79qaU/kGPypkNOLH/bLeN9Z95maeGmddY=";  # hash-updated: 2026-05-02 03:09:33
  };
  deps = [
    "elab-pretty"
    "elab-util"
    "parser-show"
  ];
}
