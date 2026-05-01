# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/hydrolarus/toml-idr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "toml";
  ipkg = "toml.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "hydrolarus";
    repo = "toml-idr";
    rev = "main";
    hash = "sha256-9sOLSTXK6SuMzjelaR8YNtTJROHouC2Yd8bjmOhGe9g=";  # hash-updated: 2026-05-02 03:10:06
  };
  deps = [ ];
}
