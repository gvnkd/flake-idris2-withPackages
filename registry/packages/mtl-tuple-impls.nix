# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-mtl-tuple-impls

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "mtl-tuple-impls";
  ipkg = "mtl-tuple-impls.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-mtl-tuple-impls";
    rev = "f25d3f8aba26da82be089f8c0e9f1865b31b28e8";
    hash = "sha256-C7jHrqI47Ie2zXiNGI0shRDUgsJRr+COI8fmfvIRGtA=";  # hash-updated: 2026-06-19 16:28:58;  # hash-updated: 2026-05-02 03:09:20
  };
  deps = [ ];
}
