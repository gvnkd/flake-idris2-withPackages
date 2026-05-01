# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-algebra

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "algebra";
  ipkg = "algebra.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-algebra";
    rev = "main";
    hash = "sha256-feBRFG/72PhDGAmK3LIJIKV2SsM7vhB1RiDSu3p9V0o=";  # hash-updated: 2026-05-02 03:07:36
  };
  deps = [ ];
}
