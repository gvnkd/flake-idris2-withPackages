# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-css

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "css";
  ipkg = "css.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-css";
    rev = "main";
    hash = "sha256-L4p8rxp0IrzIi2H1pLaqn+4dTmh8+m9+osxRq/o6zTs=";  # hash-updated: 2026-05-02 03:07:56
  };
  deps = [
    "literal"
  ];
}
