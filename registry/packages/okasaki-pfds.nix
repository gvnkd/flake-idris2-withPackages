# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://gitlab.com/bss03/idris2-okasaki-pfds

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "okasaki-pfds";
  ipkg = "okasaki-pfds.ipkg";
  src = pkgs.fetchFromGitLab {
    owner = "bss03";
    repo = "idris2-okasaki-pfds";
    rev = "master";
    hash = "sha256-1v76ZD5FQXfaA886GfV6kxn06O7duJK//jdYtu6hWUE=";  # hash-updated: 2026-05-02 03:09:25
  };
  deps = [ ];
}
