# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-rhone-js

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "rhone-js";
  ipkg = "rhone-js.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-rhone-js";
    rev = "main";
    hash = "sha256-t4sIKCyCjJerWpZxj9uUuUUVRHvN4H98AGYmrk0Gu5w=";  # hash-updated: 2026-05-02 03:09:47
  };
  deps = [
    "dom"
    "rhone"
    "refined"
    "tailrec"
  ];
}
