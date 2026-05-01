# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kiana-S/numidr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "numidr";
  ipkg = "numidr.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kiana-S";
    repo = "numidr";
    rev = "main";
    hash = "sha256-YDQ7ODnZrmBq/G4BKYIO5RgJEdS8WZV2QxFV4JUx7Mw=";  # hash-updated: 2026-05-02 03:09:24
  };
  deps = [ ];
}
