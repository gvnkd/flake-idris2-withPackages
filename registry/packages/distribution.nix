# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-bayes/distribution

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "distribution";
  ipkg = "distribution.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-bayes";
    repo = "distribution";
    rev = "main";
    hash = "sha256-Tsa9+OJG3hwlv0ykd/ISUJP91hUgB60zIqXIyTpSnsI=";  # hash-updated: 2026-05-02 03:08:04
  };
  deps = [ ];
}
