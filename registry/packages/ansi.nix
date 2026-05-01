# ANSI escape sequences
# Source: https://github.com/idris-community/idris2-ansi

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "ansi";
  ipkg = "ansi.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-ansi";
    rev = "main";
    hash = "sha256-4aD8bNxw6SEEjowAYbRUWdv8d8Uql463rBL8GW8YJvU=";
  };
}
