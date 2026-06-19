# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-bayes/log-domain

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "log-domain";
  ipkg = "log-domain.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-bayes";
    repo = "log-domain";
    rev = "7eb33c36fb411b3e9dc43e0c5ad5d8f2f3dae80e";
    hash = "sha256-peRW7d9r6lFax6LMwlPw927w04uQcdH2dHYsGtf7JJU=";  # hash-updated: 2026-06-19 16:28:49;  # hash-updated: 2026-05-02 03:09:14
  };
  deps = [ ];
}
