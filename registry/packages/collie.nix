# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/ohad/collie

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "collie";
  ipkg = "collie.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "ohad";
    repo = "collie";
    rev = "main";
    hash = "sha256-zWRIgSor6QPsI11RjRYBTH8xYSM4Ual5GK3rSX/rmGk=";  # hash-updated: 2026-05-02 03:07:48
  };
  deps = [ ];
}
