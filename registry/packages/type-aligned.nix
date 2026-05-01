# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://gitlab.com/bss03/type-aligned

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "type-aligned";
  ipkg = "type-aligned.ipkg";
  src = pkgs.fetchFromGitLab {
    owner = "bss03";
    repo = "type-aligned";
    rev = "main";
    hash = "sha256-C2nO7T8NkciY50iuD1KGCiNceLOGO34+1DOUIldoYRY=";  # hash-updated: 2026-05-02 03:10:07
  };
  deps = [
  ];
}
