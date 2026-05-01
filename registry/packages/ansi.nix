# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/idris2-ansi

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-ansi";
    rev = "main";
    hash = "sha256-4aD8bNxw6SEEjowAYbRUWdv8d8Uql463rBL8GW8YJvU=";  # hash-updated: 2026-05-02 03:07:37
  };
in
{
  ansi = buildIdrisWithDocs {
    pname = "ansi";
    ipkg = "ansi.ipkg";
    inherit src;
  deps = [ ];
  };
  prettier-ansi = buildIdrisWithDocs {
    pname = "prettier-ansi";
    ipkg = "prettier/prettier-ansi.ipkg";
    inherit src;
    deps = [
      "ansi"
      "prettier"
    ];
  };
}
