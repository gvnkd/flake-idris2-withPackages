# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/katla

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "katla";
    rev = "main";
    hash = "sha256-+7EMUS2RiuAwb+TGH1FCssV89Ib6ZI1LRIKCK916im8=";  # hash-updated: 2026-05-02 03:09:10
  };
in
{
  katla = buildIdrisWithDocs {
    pname = "katla";
    ipkg = "katla.ipkg";
    inherit src;
  deps = [
    "collie"
    "idrall"
  ];
  };
  katla-pandoc = buildIdrisWithDocs {
    pname = "katla-pandoc";
    ipkg = "katla-pandoc.ipkg";
    inherit src;
    deps = [ ];
  };
}
