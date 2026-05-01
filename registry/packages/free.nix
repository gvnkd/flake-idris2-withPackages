# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-bayes/free

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "free";
  ipkg = "free.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-bayes";
    repo = "free";
    rev = "main";
    hash = "sha256-R8d3y86Xc1x1GUucqFTdnOWeBs6V7IWWotQDOHcjUoQ=";  # hash-updated: 2026-05-02 03:08:19
  };
  deps = [ ];
}
