# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-quantifiers-extra

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "quantifiers-extra";
  ipkg = "quantifiers-extra.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-quantifiers-extra";
    rev = "5e368c5dcc7724e19b1e9eb3baf8e206cf79d2a1";
    hash = "sha256-nqHQXS4wJQKB5VIGjkiAN4QaVUcGGeWOW6NpF0oUluo=";  # hash-updated: 2026-06-19 16:29:23;  # hash-updated: 2026-05-02 03:09:37
  };
  deps = [ ];
}
