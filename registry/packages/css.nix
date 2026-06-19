# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-css

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "css";
  ipkg = "css.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-css";
    rev = "de7e9dba95dad7c3e873e41ef94c8eb8c4697cef";
    hash = "sha256-eV5lokIEt29Ej3Tbh5Ikvqt1FM6yqEjLQzZaQdFU77c=";  # hash-updated: 2026-06-19 16:27:42;  # hash-updated: 2026-05-02 03:07:56
  };
  deps = [ "literal" ];
}
