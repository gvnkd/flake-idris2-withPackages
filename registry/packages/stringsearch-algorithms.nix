# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Matthew-Mosior/idris2-stringsearch-algorithms

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "stringsearch-algorithms";
  ipkg = "stringsearch-algorithms.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Matthew-Mosior";
    repo = "idris2-stringsearch-algorithms";
    rev = "31ca9a9ac3376324ab7183242214f2a98fe358aa";
    hash = "sha256-jBSOeK72CMxM9FWVfMm2CNF3V0yCbWCEjZ6p/bUcFPE=";  # hash-updated: 2026-06-19 16:29:48;  # hash-updated: 2026-05-02 03:09:56
  };
  deps = [ "array" "bytestring" "ref1" ];
}
