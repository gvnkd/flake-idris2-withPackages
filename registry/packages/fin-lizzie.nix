# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-fin-lizzie

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "fin-lizzie";
  ipkg = "fin-lizzie.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-fin-lizzie";
    rev = "0bfed91651ea60a4b4a97ed12494da0eba769b8f";
    hash = "sha256-22/c9Vp5uTJKOa0eNyszLzLuUZMIxodNVa9HJcLHqa0=";  # hash-updated: 2026-06-19 16:28:11;  # hash-updated: 2026-05-02 03:08:17
  };
  deps = [ ];
}
