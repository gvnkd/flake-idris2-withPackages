# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/jcranch/idris-decord

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "decord";
  ipkg = "decord.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "jcranch";
    repo = "idris-decord";
    rev = "5ccae2e639f13598bdd9a34b16c72d51bcaa4350";
    hash = "sha256-r1arGnzw5C2eEvxWWMMz7NrfaJO7ytoscyPGv053N9s=";  # hash-updated: 2026-06-19 16:27:45;  # hash-updated: 2026-05-02 03:07:58
  };
  deps = [ ];
}
