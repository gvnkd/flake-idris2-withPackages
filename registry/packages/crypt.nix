# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-crypt

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "crypt";
  ipkg = "crypt.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-crypt";
    rev = "f40a54831395a2450839a4f29e50ad718a5d9953";
    hash = "sha256-1PYivAuR3AOj1rv5sPt72SKWORnUGgSUC0fakqxNEwU=";  # hash-updated: 2026-06-19 16:27:41;  # hash-updated: 2026-05-02 03:07:56
  };
  deps = [ ];
}
