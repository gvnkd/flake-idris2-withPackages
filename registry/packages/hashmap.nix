# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Z-snails/idris2-hashmap

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "hashmap";
  ipkg = "hashmap.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Z-snails";
    repo = "idris2-hashmap";
    rev = "main";
    hash = "sha256-1ISHep4t89cdJdI5ijkkjDcuVMDjqBS7cEkUvrLTeX8=";  # hash-updated: 2026-05-02 03:08:26
  };
  deps = [ "hashable" ];
}
