# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-pretty-show

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "pretty-show";
  ipkg = "pretty-show.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-pretty-show";
    rev = "b49cc6197aa9c6ca4bc941519f3088950a0c05a3";
    hash = "sha256-StgfV4cgLt79qaU/kGPypkNOLH/bLeN9Z95maeGmddY=";  # hash-updated: 2026-06-19 16:29:16;  # hash-updated: 2026-05-02 03:09:33
  };
  deps = [ "elab-pretty" "elab-util" "parser-show" ];
}
