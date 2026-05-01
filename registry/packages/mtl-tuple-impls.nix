# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-mtl-tuple-impls

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "mtl-tuple-impls";
  ipkg = "mtl-tuple-impls.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-mtl-tuple-impls";
    rev = "master";
    hash = "sha256-C7jHrqI47Ie2zXiNGI0shRDUgsJRr+COI8fmfvIRGtA=";  # hash-updated: 2026-05-02 03:09:20
  };
  deps = [ ];
}
