# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/deptycheck

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "deptycheck";
    rev = "660a23e6da286359af6edad09b5d441a39a4f8c5";
    hash = "sha256-5fN0UcMsXgV0IjitGlI5CXc9vcBmRTmN0YH/ZnNajik=";  # hash-updated: 2026-06-19 16:27:50;  # hash-updated: 2026-05-02 03:08:02
  };
in
{
  deptycheck = buildIdrisWithDocs {
    pname = "deptycheck";
    ipkg = "deptycheck.ipkg";
    inherit src;
  deps = [ "ansi" "best-alternative" "dependent-vect" "elab-util-extra" "i-hate-parens" "if-unsolved-implicit" "mtl-tuple-impls" "positive-nat" "random-pure" "typelevel-emptiness-collections" ];
  };
  elab-util-extra = buildIdrisWithDocs {
    pname = "elab-util-extra";
    ipkg = "elab-util-extra/elab-util-extra.ipkg";
    inherit src;
    deps = [ "collection-utils" "containers" "cozippable" "elab-pretty" "elab-util" "fin-lizzie" "i-hate-parens" "mk" "mtl-tuple-impls" ];
  };
}
