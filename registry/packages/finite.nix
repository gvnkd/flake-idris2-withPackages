# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-finite

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "finite";
  ipkg = "finite.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-finite";
    rev = "main";
    hash = "sha256-rCqDXN2FC5vGCJCZOh085df1cDKCMQXqhsojPQa5b18=";  # hash-updated: 2026-05-02 03:08:16
  };
  deps = [
    "elab-util"
  ];
}
