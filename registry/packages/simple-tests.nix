# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://gitlab.com/avidela/idris2-simple-tests

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "simple-tests";
  ipkg = "simple-tests.ipkg";
  src = pkgs.fetchFromGitLab {
    owner = "avidela";
    repo = "idris2-simple-tests";
    rev = "main";
    hash = "sha256-9nxhzzv2qdm28x9mhSMtn6/yJ/+JvpdvNjZAp5nFCWs=";  # hash-updated: 2026-05-02 03:09:50
  };
  deps = [ ];
}
