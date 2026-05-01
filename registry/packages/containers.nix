# Containers (Map, Set, etc.)
# Source: https://github.com/idris-community/idris2-containers
# Depends on: elab-util

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "containers";
  ipkg = "containers.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-containers";
    rev = "main";
    hash = "sha256-VTK8cWu3NflQ1E9jSSjeP6MbG+sx0HouBPBIE6c2U/k=";
  };
  deps = [ "elab-util" ];
}
