# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/idris2-scgi

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "scgi";
  ipkg = "scgi.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-scgi";
    rev = "main";
    hash = "sha256-jPpgorj2NA/63t3hHRAkz7DeZvFdeofGUrGwGei8mqs=";  # hash-updated: 2026-05-02 03:09:50
  };
  deps = [ "ansi" "async-epoll" "http-server-api" ];
}
