# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kbertalan/idris2-apache-mime-types

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "apache-mime-types";
  ipkg = "apache-mime-types.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kbertalan";
    repo = "idris2-apache-mime-types";
    rev = "main";
    hash = "sha256-1VrAjfwwKqYilgXIlHMUOcp8ZBj4Sq6EwZLYR95er70=";  # hash-updated: 2026-05-02 03:07:38
  };
  deps = [ ];
}
