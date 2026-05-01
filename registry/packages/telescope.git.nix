# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://gitlab.com/avidela/idris2-telescope.git

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "telescope";
  ipkg = "telescope.ipkg";
  src = pkgs.fetchFromGitLab {
    owner = "avidela";
    repo = "idris2-telescope";
    rev = "main";
    hash = "sha256-GB5nFcTFJhihkUNhYzk0+PMDJ+wC22PzVCsasHXRtKY=";  # hash-updated: 2026-05-02 03:11:14
  };
  deps = [ ];
}
