# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-ref1

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "ref1";
  ipkg = "ref1.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-ref1";
    rev = "f7a20a9e41aba4026b50edddd689fc394d354b97";
    hash = "sha256-BlOv+kvMvtETi6cWSOwT+cvs0bYkQq72HeKA+OCRrlI=";  # hash-updated: 2026-06-19 16:29:30;  # hash-updated: 2026-05-02 03:09:42
  };
  deps = [ ];
}
