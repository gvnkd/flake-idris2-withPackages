# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-if-unsolved-implicit

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "if-unsolved-implicit";
  ipkg = "if-unsolved-implicit.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-if-unsolved-implicit";
    rev = "master";
    hash = "sha256-PMXxhLf/r6X2WlI+FEaAKEQej7rsulhYpSmdoY/tTcY=";  # hash-updated: 2026-05-02 03:09:03
  };
  deps = [ ];
}
