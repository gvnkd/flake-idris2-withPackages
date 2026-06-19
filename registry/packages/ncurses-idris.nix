# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/mattpolzin/ncurses-idris

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "ncurses-idris";
  ipkg = "ncurses-idris.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "mattpolzin";
    repo = "ncurses-idris";
    rev = "9f1e575d48cb2acb837f9713e003fbb6ddbf8f44";
    hash = "sha256-Yh1I30Jg3Z0/8ZlQlekP+PTXhgnfwxs6J69J1Up3fnk=";  # hash-updated: 2026-06-19 16:29:01;  # hash-updated: 2026-05-02 03:09:21
  };
  deps = [ "indexed" ];
}
