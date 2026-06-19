# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-epoll

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "epoll";
  ipkg = "epoll.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-epoll";
    rev = "996777313593ef4e38509f49255800ba2b322588";
    hash = "sha256-r4Fe3pOyVKuMmpJfiqYK4O6cWXv1X9eCOk7Fv48eGm4=";  # hash-updated: 2026-06-19 16:28:06;  # hash-updated: 2026-05-02 03:08:12
  };
  deps = [ "array" "elab-util" "finite" ];
}
