# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-i-hate-parens

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "i-hate-parens";
  ipkg = "i-hate-parens.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-i-hate-parens";
    rev = "master";
    hash = "sha256-XsUh2aA7ZdX6UxmTB9Xo3bpn5gR3DBm2ENq2Y5Q9DEA=";  # hash-updated: 2026-05-02 03:09:04
  };
  deps = [ "if-unsolved-implicit" ];
}
