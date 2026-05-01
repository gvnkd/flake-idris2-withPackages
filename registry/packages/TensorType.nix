# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/bgavran/TensorType

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "tensortype";
  ipkg = "tensortype.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "bgavran";
    repo = "TensorType";
    rev = "main";
    hash = "sha256-b296oVvnVeGjAjusI3Z8MI8AJfyKygYws0tA56uC90g=";  # hash-updated: 2026-05-02 03:10:01
  };
  deps = [
    "elab-util"
    "hashmap"
    "finite"
  ];
}
