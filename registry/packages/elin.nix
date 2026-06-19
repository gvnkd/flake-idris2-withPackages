# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-elin

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "elin";
  ipkg = "elin.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-elin";
    rev = "c66a6709397431150235e8bdddc0a21fcbedb7de";
    hash = "sha256-sG1cFnOI8SDFEV/qwu2vEQY2hD+0Kp72Z198/LCY1tA=";  # hash-updated: 2026-06-19 16:28:05;  # hash-updated: 2026-05-02 03:08:11
  };
  deps = [ "quantifiers-extra" "ref1" ];
}
