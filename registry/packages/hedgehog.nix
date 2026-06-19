# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-hedgehog

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "hedgehog";
  ipkg = "hedgehog.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-hedgehog";
    rev = "de4d9b15278848f2ee2b99249a73899ef07eda57";
    hash = "sha256-W1M0QHeqSLs5f6xwk0f1CalhwG1IqXqSnpR9aNwiIV8=";  # hash-updated: 2026-06-19 16:28:28;  # hash-updated: 2026-05-02 03:08:27
  };
  deps = [ "ansi" "elab-pretty" "elab-util" "getopts" "prettier-ansi" "pretty-show" "random-pure" "sop" "summary-stat" ];
}
