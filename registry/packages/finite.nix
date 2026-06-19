# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-finite

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "finite";
  ipkg = "finite.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-finite";
    rev = "5d9a9de5466030f3ffc5a0c2ad4ef647bc882a30";
    hash = "sha256-rCqDXN2FC5vGCJCZOh085df1cDKCMQXqhsojPQa5b18=";  # hash-updated: 2026-06-19 16:28:13;  # hash-updated: 2026-05-02 03:08:16
  };
  deps = [ "elab-util" ];
}
