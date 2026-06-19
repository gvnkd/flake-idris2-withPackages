# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-i-hate-parens

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "i-hate-parens";
  ipkg = "i-hate-parens.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-i-hate-parens";
    rev = "c1ef924566319a9fec0ed8033c78f4b76798446b";
    hash = "sha256-XsUh2aA7ZdX6UxmTB9Xo3bpn5gR3DBm2ENq2Y5Q9DEA=";  # hash-updated: 2026-06-19 16:28:32;  # hash-updated: 2026-05-02 03:09:04
  };
  deps = [ "if-unsolved-implicit" ];
}
