# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-refined

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-refined";
    rev = "main";
    hash = "sha256-NB9XfZAusfdqqO58p0Yy8YpmeFjzf9Ycm5+TjPeLP3s=";  # hash-updated: 2026-05-02 03:09:43
  };
in
{
  refined = buildIdrisWithDocs {
    pname = "refined";
    ipkg = "refined.ipkg";
    inherit src;
  deps = [
    "elab-util"
    "algebra"
  ];
  };
  refined-json = buildIdrisWithDocs {
    pname = "refined-json";
    ipkg = "json/refined-json.ipkg";
    inherit src;
    deps = [
      "refined"
      "json-simple"
    ];
  };
  refined-tsv = buildIdrisWithDocs {
    pname = "refined-tsv";
    ipkg = "tsv/refined-tsv.ipkg";
    inherit src;
    deps = [
      "refined"
      "parser-tsv"
    ];
  };
}
