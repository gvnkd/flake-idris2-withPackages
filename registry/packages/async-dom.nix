# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-async-dom

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "async-dom";
  ipkg = "async-dom.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-async-dom";
    rev = "df08a47277538ea8a3c068267e5f60dbaf6417cd";
    hash = "sha256-cIpEubVpYYZyOExwSK1Rue8/ByabrPyPNho6rPbRRIw=";  # hash-updated: 2026-06-19 16:27:16;  # hash-updated: 2026-05-02 03:07:41
  };
  deps = [ "async-js" "barbies" "css" "dom" "json-simple" "monocle" "streams" ];
}
