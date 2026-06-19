# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-bayes/monad-bayes

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "monad-bayes";
  ipkg = "monad-bayes.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-bayes";
    repo = "monad-bayes";
    rev = "6b8d3015a2317ab11e4a9205924d61094f570665";
    hash = "sha256-EXGRrd1Mz1fm/JBFXMX5Rj0eMvQvI/j2fCs3PHcZuXs=";  # hash-updated: 2026-06-19 16:28:56;  # hash-updated: 2026-05-02 03:09:18
  };
  deps = [ "distribution" "free" "log-domain" ];
}
