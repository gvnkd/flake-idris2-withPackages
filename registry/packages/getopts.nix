# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/idris2-getopts

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "getopts";
  ipkg = "getopts.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-getopts";
    rev = "main";
    hash = "sha256-CthWByg4uFic0ktri1AuFqkHtyRzIUrreCTegQgdpVo=";  # hash-updated: 2026-05-02 03:08:21
  };
  deps = [ ];
}
