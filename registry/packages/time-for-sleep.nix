# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-time-for-sleep

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "time-for-sleep";
  ipkg = "time-for-sleep.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-time-for-sleep";
    rev = "master";
    hash = "sha256-nWDrxqEfriwhUoF5xuFIk9ywOgAg1CKHYpOXQg3HIm0=";  # hash-updated: 2026-05-02 03:10:04
  };
  deps = [ ];
}
