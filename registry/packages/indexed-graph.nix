# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-indexed-graph

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "indexed-graph";
  ipkg = "indexed-graph.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-indexed-graph";
    rev = "b8f1fb1157cbe6ac9b487efa81284ab4342169af";
    hash = "sha256-ZxAO98XYkd7C7D3VcRkenxDV/H8cJTwmrA/8cgGQLqw=";  # hash-updated: 2026-06-19 16:28:38;  # hash-updated: 2026-05-02 03:09:06
  };
  deps = [ "array" "containers" ];
}
