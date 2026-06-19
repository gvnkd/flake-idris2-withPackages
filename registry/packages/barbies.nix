# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-barbies

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "barbies";
  ipkg = "barbies.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-barbies";
    rev = "257201868668f94884a12c3de3b48ed84fce3a07";
    hash = "sha256-XpiCkFjIIXB9LyH0RunvTYDKgfivhVmVspT8CVmR+u8=";  # hash-updated: 2026-06-19 16:27:19;  # hash-updated: 2026-05-02 03:07:41
  };
  deps = [ "elab-util" "monocle" ];
}
