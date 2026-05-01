# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/running-grass/idris2-url

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "url";
  ipkg = "url.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "running-grass";
    repo = "idris2-url";
    rev = "main";
    hash = "sha256-YHqdpoer56mZQsvG9a+FLDKDZzutFL6hje0h5VAOMyU=";  # hash-updated: 2026-05-02 03:10:13
  };
  deps = [ ];
}
