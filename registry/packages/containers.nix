# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/idris2-containers

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "containers";
  ipkg = "containers.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-containers";
    rev = "main";
    hash = "sha256-VTK8cWu3NflQ1E9jSSjeP6MbG+sx0HouBPBIE6c2U/k=";  # hash-updated: 2026-05-02 03:07:51
  };
  deps = [ "array" "elab-util" "hashable" "ref1" ];
}
