# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/mattpolzin/pg-idris

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "pg-idris";
  ipkg = "pg-idris.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "mattpolzin";
    repo = "pg-idris";
    rev = "main";
    hash = "sha256-w8wusaIBbB25Eje42WFZxHgCS1/gEifpqdZjJQMrDAs=";  # hash-updated: 2026-05-02 03:09:30
  };
  deps = [ "indexed" "parser-json" ];
}
