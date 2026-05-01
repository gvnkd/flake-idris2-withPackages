# Parser combinators
# Source: https://github.com/stefan-hoeck/idris2-parser
# Depends on: elab-util

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "parser";
  ipkg = "parser.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-parser";
    rev = "main";
    hash = "sha256-FU3XgtyVN5oh8JEu6MOx19H1eN2t99JAi3Dz25ZaSxc=";
  };
  deps = [ "elab-util" ];
}
