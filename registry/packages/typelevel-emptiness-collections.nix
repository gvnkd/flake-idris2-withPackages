# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-typelevel-emptiness-collections

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "typelevel-emptiness-collections";
  ipkg = "typelevel-emptiness-collections.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-typelevel-emptiness-collections";
    rev = "bfb00b9ee20abbeea0254fc93ca51765fb2ec851";
    hash = "sha256-3f2rZxxkki7GYAnQuAFNTww18v/bgWlwbPbJHlD7mI0=";  # hash-updated: 2026-06-19 16:30:05;  # hash-updated: 2026-05-02 03:10:08
  };
  deps = [ "if-unsolved-implicit" ];
}
