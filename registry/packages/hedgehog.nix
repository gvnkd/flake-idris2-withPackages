# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-hedgehog

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "hedgehog";
  ipkg = "hedgehog.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-hedgehog";
    rev = "main";
    hash = "sha256-YPO0sWZ+QWafLsG4g9dVYO6IkOEAcLtIgXZBpRX2ghY=";  # hash-updated: 2026-05-02 03:08:27
  };
  deps = [
    "ansi"
    "elab-pretty"
    "elab-util"
    "getopts"
    "prettier-ansi"
    "pretty-show"
    "random-pure"
    "sop"
    "summary-stat"
  ];
}
