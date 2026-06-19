# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-comonad

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "comonad";
  ipkg = "comonad.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-comonad";
    rev = "154292a389edd7496bd4f41465bcba6844cede52";
    hash = "sha256-Y8gEVJzf150RmMerSjrzgA4kia7UMEkjp/Wk3f1hLR8=";  # hash-updated: 2026-06-19 16:27:31;  # hash-updated: 2026-05-02 03:07:49
  };
  deps = [ ];
}
