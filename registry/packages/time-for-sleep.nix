# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-time-for-sleep

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "time-for-sleep";
  ipkg = "time-for-sleep.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-time-for-sleep";
    rev = "8e50060df0d6ff19d6049b90bd26906a6b4aae5f";
    hash = "sha256-nWDrxqEfriwhUoF5xuFIk9ywOgAg1CKHYpOXQg3HIm0=";  # hash-updated: 2026-06-19 16:29:59;  # hash-updated: 2026-05-02 03:10:04
  };
  deps = [ ];
}
