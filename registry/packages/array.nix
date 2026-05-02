# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-array

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "array";
  ipkg = "array.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-array";
    rev = "main";
    hash = "sha256-Cn8RscraiH97Wiv/E+qNwaIc17zcxT33EaPz3E55kMU=";  # hash-updated: 2026-05-02 03:06:26
  };
  deps = [ "algebra" "ref1" ];
}
