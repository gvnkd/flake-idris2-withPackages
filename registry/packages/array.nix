# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-array

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "array";
  ipkg = "array.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-array";
    rev = "7cca4fe58f28436b73f077e836c09fce091da4e9";
    hash = "sha256-M6O7iNK7S/1ahN4CP9HZ13DaYxrevLQyb8khmkvFNic=";  # hash-updated: 2026-06-19 16:27:12;  # hash-updated: 2026-05-02 03:06:26
  };
  deps = [ "algebra" "ref1" ];
}
