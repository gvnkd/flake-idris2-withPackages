# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-bayes/log-domain

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "log-domain";
  ipkg = "log-domain.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-bayes";
    repo = "log-domain";
    rev = "main";
    hash = "sha256-peRW7d9r6lFax6LMwlPw927w04uQcdH2dHYsGtf7JJU=";  # hash-updated: 2026-05-02 03:09:14
  };
  deps = [ ];
}
