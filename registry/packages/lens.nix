# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kiana-S/idris2-lens

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "lens";
  ipkg = "lens.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kiana-S";
    repo = "idris2-lens";
    rev = "main";
    hash = "sha256-JV7fdlF39Y0uUlUJsMG6t+X9N+Dd+/twIfb6Rhlg8OU=";  # hash-updated: 2026-05-02 03:09:11
  };
  deps = [ "elab-util" "profunctors" ];
}
