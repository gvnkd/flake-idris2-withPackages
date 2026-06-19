# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-rhone-js

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "rhone-js";
  ipkg = "rhone-js.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-rhone-js";
    rev = "543fa513206018ab152791e090746f09df551d76";
    hash = "sha256-t4sIKCyCjJerWpZxj9uUuUUVRHvN4H98AGYmrk0Gu5w=";  # hash-updated: 2026-06-19 16:29:36;  # hash-updated: 2026-05-02 03:09:47
  };
  deps = [ "dom" "refined" "rhone" "tailrec" ];
}
