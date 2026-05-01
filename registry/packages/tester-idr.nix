# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/hydrolarus/tester-idr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "tester";
  ipkg = "tester.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "hydrolarus";
    repo = "tester-idr";
    rev = "main";
    hash = "sha256-zKWo7DSnp+WeOEGvzDGlM3CpOU7xg0WwBW4S86Y/9tE=";  # hash-updated: 2026-05-02 03:10:02
  };
  deps = [ ];
}
