# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://gitlab.com/bss03/nested

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "nested";
  ipkg = "nested.ipkg";
  src = pkgs.fetchFromGitLab {
    owner = "bss03";
    repo = "nested";
    rev = "main";
    hash = "sha256-OIKlj1medYZqh+Js7ZYly1NB+8jNBqnDgFZj3kQ9txc=";  # hash-updated: 2026-05-02 03:09:22
  };
  deps = [ ];
}
