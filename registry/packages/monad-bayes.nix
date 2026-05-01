# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-bayes/monad-bayes

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "monad-bayes";
  ipkg = "monad-bayes.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-bayes";
    repo = "monad-bayes";
    rev = "main";
    hash = "sha256-EXGRrd1Mz1fm/JBFXMX5Rj0eMvQvI/j2fCs3PHcZuXs=";  # hash-updated: 2026-05-02 03:09:18
  };
  deps = [
    "free"
    "distribution"
    "log-domain"
  ];
}
