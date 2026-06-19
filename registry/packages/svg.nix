# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-svg

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "svg";
  ipkg = "svg.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-svg";
    rev = "dc4784fe70f45cc25f9bdd212df0dd6a0e9a67eb";
    hash = "sha256-k4C2zk524RqEIrtYiKDDELPVRo/cr7tUk1G9ArlAFBs=";  # hash-updated: 2026-06-19 16:29:51;  # hash-updated: 2026-05-02 03:09:57
  };
  deps = [ "elab-util" "refined" ];
}
