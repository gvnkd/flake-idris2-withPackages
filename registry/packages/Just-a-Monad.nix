# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Russoul/Just-a-Monad

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "just-a-monad";
  ipkg = "just-a-monad.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Russoul";
    repo = "Just-a-Monad";
    rev = "main";
    hash = "sha256-oPR+YHnqO6CQdzBdU9I/a0UXlqokJEdQtnqKyh8DCOQ=";  # hash-updated: 2026-05-02 03:09:09
  };
  deps = [ ];
}
