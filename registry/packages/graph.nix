# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-graph

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "graph";
  ipkg = "graph.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-graph";
    rev = "e3fea89ac3e2edc371966f5540deac690f85e31a";
    hash = "sha256-zvOel5wLuR/dO6DaInOyRJS/sJpFbzb2e97wNPQPWOQ=";  # hash-updated: 2026-06-19 16:28:24;  # hash-updated: 2026-05-02 03:08:24
  };
  deps = [ "algebra" ];
}
