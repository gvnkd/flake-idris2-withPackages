# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-dom-mvc

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-dom-mvc";
    rev = "main";
    hash = "sha256-WKlnvu/Y0vt5wdGZKMdSZLyr+33Ueo8n2j7nSir5w7g=";  # hash-updated: 2026-05-02 03:08:06
  };
in
{
  dom-mvc = buildIdrisWithDocs {
    pname = "dom-mvc";
    ipkg = "dom-mvc.ipkg";
    inherit src;
  deps = [
    "dom"
    "containers"
    "json-simple"
    "refined"
    "tailrec"
    "css"
  ];
  };
  dom-mvc-extra = buildIdrisWithDocs {
    pname = "dom-mvc-extra";
    ipkg = "extra/dom-mvc-extra.ipkg";
    inherit src;
    deps = [
      "dom-mvc"
      "monocle"
      "barbies"
      "filepath"
    ];
  };
}
