# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kbertalan/idris2-go

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "kbertalan";
    repo = "idris2-go";
    rev = "main";
    hash = "sha256-JxUClhZyf1L6xBWfgW/8UxXFTXRUCbYkDkvCYn6EVAs=";  # hash-updated: 2026-05-02 03:08:23
  };
in
{
  idris2-go = buildIdrisWithDocs {
    pname = "idris2-go";
    ipkg = "idris2-go.ipkg";
    inherit src;
  deps = [ ];
  };
  idris2-go-lib = buildIdrisWithDocs {
    pname = "idris2-go-lib";
    ipkg = "idris2-go-lib.ipkg";
    inherit src;
    deps = [ ];
  };
}
