# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-prim

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "prim";
  ipkg = "prim.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-prim";
    rev = "a875bbe1f11638946383b80eaf27bc471e56e341";
    hash = "sha256-72c2GUcBXnLE30ZlH0ZwRlOUfsNUaX+yD9MWA6mT2oY=";  # hash-updated: 2026-06-19 16:29:18;  # hash-updated: 2026-05-02 03:09:34
  };
  deps = [ ];
}
