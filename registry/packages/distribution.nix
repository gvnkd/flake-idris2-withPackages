# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-bayes/distribution

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "distribution";
  ipkg = "distribution.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-bayes";
    repo = "distribution";
    rev = "bced45ab5367184c8a4d88ce695c9a4714c34c98";
    hash = "sha256-Tsa9+OJG3hwlv0ykd/ISUJP91hUgB60zIqXIyTpSnsI=";  # hash-updated: 2026-06-19 16:27:53;  # hash-updated: 2026-05-02 03:08:04
  };
  deps = [ ];
}
