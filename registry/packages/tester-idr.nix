# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/hydrolarus/tester-idr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "tester";
  ipkg = "tester.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "hydrolarus";
    repo = "tester-idr";
    rev = "3dcdb54ed578a14597a17cb93c926734a9da69ca";
    hash = "sha256-zKWo7DSnp+WeOEGvzDGlM3CpOU7xg0WwBW4S86Y/9tE=";  # hash-updated: 2026-06-19 16:29:56;  # hash-updated: 2026-05-02 03:10:02
  };
  deps = [ ];
}
