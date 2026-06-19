# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/CodingCellist/idris2-dot-parse

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "dot-gv";
  ipkg = "dot-parse.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "CodingCellist";
    repo = "idris2-dot-parse";
    rev = "369fe32ed8d716cee6a07969b7b31e6d2cf046ae";
    hash = "sha256-7rzV7pEH+PerjRJohNq0nUWcD7mNsAp6vxkY9auQSlY=";  # hash-updated: 2026-06-19 16:27:59;  # hash-updated: 2026-05-02 03:08:08
  };
  deps = [ "idris2" ];
}
