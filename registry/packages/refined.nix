# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-refined

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-refined";
    rev = "7ad095dc89232cfa667e47ae507b13f132837fdd";
    hash = "sha256-UWyNTSF7k3DLgHczRhut32HJfc2igjGkTVYi0NeXr9s=";  # hash-updated: 2026-06-19 16:29:32;  # hash-updated: 2026-05-02 03:09:43
  };
in
{
  refined = buildIdrisWithDocs {
    pname = "refined";
    ipkg = "refined.ipkg";
    inherit src;
  deps = [ "algebra" "elab-util" ];
  };
  refined-json = buildIdrisWithDocs {
    pname = "refined-json";
    ipkg = "json/refined-json.ipkg";
    inherit src;
    deps = [ "json-simple" "refined" ];
  };
  refined-tsv = buildIdrisWithDocs {
    pname = "refined-tsv";
    ipkg = "tsv/refined-tsv.ipkg";
    inherit src;
    deps = [ "parser-tsv" "refined" ];
  };
}
