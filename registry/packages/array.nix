# Arrays (mutable and immutable)
# Source: https://github.com/stefan-hoeck/idris2-array
# Depends on: algebra, ref1

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "array";
  ipkg = "array.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-array";
    rev = "main";
    hash = "sha256-Cn8RscraiH97Wiv/E+qNwaIc17zcxT33EaPz3E55kMU=";
  };
  deps = [ "algebra" "ref1" ];
}
