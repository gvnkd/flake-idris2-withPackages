# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-bytestring

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "bytestring";
  ipkg = "bytestring.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-bytestring";
    rev = "1c5c6160eef2a91b222d219383af6901c74b57e0";
    hash = "sha256-ae8ZfS+Je6K1tWNTzVqgPgbuRxcA51dzg5lChpiT52w=";  # hash-updated: 2026-06-19 16:27:24;  # hash-updated: 2026-05-02 03:07:45
  };
  deps = [ "algebra" "array" ];
}
