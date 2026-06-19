# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Z-snails/idris2-hashmap

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "hashmap";
  ipkg = "hashmap.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Z-snails";
    repo = "idris2-hashmap";
    rev = "5c3e42ce1a85b04dca1105c2513299404c8427e3";
    hash = "sha256-1ISHep4t89cdJdI5ijkkjDcuVMDjqBS7cEkUvrLTeX8=";  # hash-updated: 2026-06-19 16:28:27;  # hash-updated: 2026-05-02 03:08:26
  };
  deps = [ "hashable" ];
}
