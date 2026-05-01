# Algebra package - lawful algebraic structures
# Source: https://github.com/stefan-hoeck/idris2-algebra

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "algebra";
  ipkg = "algebra.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-algebra";
    rev = "main";
    hash = "sha256-feBRFG/72PhDGAmK3LIJIKV2SsM7vhB1RiDSu3p9V0o=";
  };
}
