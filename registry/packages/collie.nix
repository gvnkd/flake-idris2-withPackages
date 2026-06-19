# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/ohad/collie

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "collie";
  ipkg = "collie.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "ohad";
    repo = "collie";
    rev = "a35498d8d5d24ae677458aa0b54afeea0c8b7198";
    hash = "sha256-zWRIgSor6QPsI11RjRYBTH8xYSM4Ual5GK3rSX/rmGk=";  # hash-updated: 2026-06-19 16:27:29;  # hash-updated: 2026-05-02 03:07:48
  };
  deps = [ ];
}
