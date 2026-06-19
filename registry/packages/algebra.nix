# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-algebra

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "algebra";
  ipkg = "algebra.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-algebra";
    rev = "b80241edadc9237c2663df098c27e6dbc99886d0";
    hash = "sha256-a+mIn6pxEOyo6urbzauVyam54VFwm+BI2IXsDTSHuOs=";  # hash-updated: 2026-06-19 16:27:08;  # hash-updated: 2026-05-02 03:07:36
  };
  deps = [ ];
}
