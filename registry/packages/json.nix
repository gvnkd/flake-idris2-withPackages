# JSON parsing and serialization
# Source: https://github.com/stefan-hoeck/idris2-json
# Depends on: parser, elab-util

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "json";
  ipkg = "json.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-json";
    rev = "main";
    hash = "sha256-w/o7U/+ydW/2xGhg9NksOkpzB8I7F8h8pwTwh5wlGoQ=";
  };
  deps = [ "parser" "elab-util" ];
}
