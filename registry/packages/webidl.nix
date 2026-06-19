# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-webidl

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "webidl";
  ipkg = "webidl.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-webidl";
    rev = "eaf66e8247dac112fd535cb3371a300d5a220fd7";
    hash = "sha256-IWi36o1J9QdHvSqazg3KGgL960xg6nRbo8CdsWOJfec=";  # hash-updated: 2026-06-19 16:30:15;  # hash-updated: 2026-05-02 03:10:16
  };
  deps = [ "getopts" "parser-webidl" "prettier" ];
}
