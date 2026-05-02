# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-svg

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "svg";
  ipkg = "svg.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-svg";
    rev = "main";
    hash = "sha256-k4C2zk524RqEIrtYiKDDELPVRo/cr7tUk1G9ArlAFBs=";  # hash-updated: 2026-05-02 03:09:57
  };
  deps = [ "elab-util" "refined" ];
}
