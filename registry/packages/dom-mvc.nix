# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-dom-mvc

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-dom-mvc";
    rev = "de2c2b37e06410c48388ef629c07c6b26fe64b34";
    hash = "sha256-WKlnvu/Y0vt5wdGZKMdSZLyr+33Ueo8n2j7nSir5w7g=";  # hash-updated: 2026-06-19 16:27:56;  # hash-updated: 2026-05-02 03:08:06
  };
in
{
  dom-mvc = buildIdrisWithDocs {
    pname = "dom-mvc";
    ipkg = "dom-mvc.ipkg";
    inherit src;
  deps = [ "containers" "css" "dom" "json-simple" "refined" "tailrec" ];
  };
  dom-mvc-extra = buildIdrisWithDocs {
    pname = "dom-mvc-extra";
    ipkg = "extra/dom-mvc-extra.ipkg";
    inherit src;
    deps = [ "barbies" "dom-mvc" "filepath" "monocle" ];
  };
}
