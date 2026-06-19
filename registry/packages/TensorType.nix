# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/bgavran/TensorType

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "tensortype";
  ipkg = "tensortype.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "bgavran";
    repo = "TensorType";
    rev = "8fedb3ec31a203d30ed82f8d6d3548bf7c22b9a1";
    hash = "sha256-0QnTyDNzKLc0gnWlXnk3+HfB2IOlzsg3KcW7F7ESqmA=";  # hash-updated: 2026-06-19 16:27:05;  # hash-updated: 2026-05-02 03:10:01
  };
  deps = [ "elab-util" "finite" "hashmap" ];
}
