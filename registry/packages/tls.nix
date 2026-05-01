# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/idris2-tls

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "tls";
  ipkg = "tls.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-tls";
    rev = "master";
    hash = "sha256-ZgU+TjdySIFse+MYFHzTSI5SjoJR5y8RDerltb4rRiE=";  # hash-updated: 2026-05-02 03:10:05
  };
  deps = [
    "sop"
    "elab-util"
  ];
}
