# Graph library
# Source: https://github.com/stefan-hoeck/idris2-graph
# Depends on: elab-util

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "graph";
  ipkg = "graph.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-graph";
    rev = "main";
    hash = "sha256-zvOel5wLuR/dO6DaInOyRJS/sJpFbzb2e97wNPQPWOQ=";
  };
  deps = [ "elab-util" ];
}
