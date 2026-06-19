# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kiana-S/idris2-lens

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "lens";
  ipkg = "lens.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kiana-S";
    repo = "idris2-lens";
    rev = "d6bae26222a0b2290bf4146279bdc31bb900d527";
    hash = "sha256-JV7fdlF39Y0uUlUJsMG6t+X9N+Dd+/twIfb6Rhlg8OU=";  # hash-updated: 2026-06-19 16:28:44;  # hash-updated: 2026-05-02 03:09:11
  };
  deps = [ "elab-util" "profunctors" ];
}
