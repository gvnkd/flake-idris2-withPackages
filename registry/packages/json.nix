# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-json

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-json";
    rev = "main";
    hash = "sha256-w/o7U/+ydW/2xGhg9NksOkpzB8I7F8h8pwTwh5wlGoQ=";  # hash-updated: 2026-05-02 03:09:08
  };
in
{
  json = buildIdrisWithDocs {
    pname = "json";
    ipkg = "json.ipkg";
    inherit src;
  deps = [ "elab-util" "ilex-json" "parser" ];
  };
  json-simple = buildIdrisWithDocs {
    pname = "json-simple";
    ipkg = "simple/json-simple.ipkg";
    inherit src;
    deps = [ "elab-util" "ilex-json" ];
  };
}
