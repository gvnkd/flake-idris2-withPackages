# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-graph

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "graph";
  ipkg = "graph.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-graph";
    rev = "main";
    hash = "sha256-zvOel5wLuR/dO6DaInOyRJS/sJpFbzb2e97wNPQPWOQ=";  # hash-updated: 2026-05-02 03:08:24
  };
  deps = [ "algebra" ];
}
