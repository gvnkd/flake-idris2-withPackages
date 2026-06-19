# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/idris2-scgi

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "scgi";
  ipkg = "scgi.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-scgi";
    rev = "7551730d60a37b67cd1e7a9557bb588dfc168545";
    hash = "sha256-Tnv7EFafZuBEYrf1yimWTHFWjIeBcqg1511echMIwQ4=";  # hash-updated: 2026-06-19 16:29:40;  # hash-updated: 2026-05-02 03:09:50
  };
  deps = [ "ansi" "async-epoll" "http-server-api" ];
}
