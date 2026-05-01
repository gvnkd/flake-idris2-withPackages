# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-quantifiers-extra

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "quantifiers-extra";
  ipkg = "quantifiers-extra.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-quantifiers-extra";
    rev = "main";
    hash = "sha256-nqHQXS4wJQKB5VIGjkiAN4QaVUcGGeWOW6NpF0oUluo=";  # hash-updated: 2026-05-02 03:09:37
  };
  deps = [ ];
}
