# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-chem

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-chem";
    rev = "main";
    hash = "sha256-9rGRhprAxyAbr3ofDSC6m5++qpr0wO1WFG3mncQSByo=";  # hash-updated: 2026-05-02 03:07:47
  };
in
{
  chem = buildIdrisWithDocs {
    pname = "chem";
    ipkg = "chem.ipkg";
    inherit src;
  deps = [
    "elab-util"
    "finite"
    "ilex"
    "indexed-graph"
    "pretty-show"
    "quantifiers-extra"
    "refined"
  ];
  };
  chem-generators = buildIdrisWithDocs {
    pname = "chem-generators";
    ipkg = "chem-generators/chem-generators.ipkg";
    inherit src;
    deps = [
      "chem"
      "hedgehog"
    ];
  };
}
