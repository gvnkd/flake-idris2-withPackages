# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/hydrolarus/toml-idr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "toml";
  ipkg = "toml.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "hydrolarus";
    repo = "toml-idr";
    rev = "7e5c4f3cc2ff028f665653b43c4c1f9b0a8211e2";
    hash = "sha256-9sOLSTXK6SuMzjelaR8YNtTJROHouC2Yd8bjmOhGe9g=";  # hash-updated: 2026-06-19 16:30:04;  # hash-updated: 2026-05-02 03:10:06
  };
  deps = [ ];
}
