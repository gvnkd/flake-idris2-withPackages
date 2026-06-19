# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-dom

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-dom";
    rev = "2bb2071a849f2ffd07211cb5f23b9e39c9ded319";
    hash = "sha256-iusWo5+5MBzUxszxeY6XayQl7+ThX13XckKlkdir3Bc=";  # hash-updated: 2026-06-19 16:27:58;  # hash-updated: 2026-05-02 03:08:07
  };
in
{
  dom = buildIdrisWithDocs {
    pname = "dom";
    ipkg = "dom.ipkg";
    inherit src;
  deps = [ "elab-util" "js" ];
  };
  js = buildIdrisWithDocs {
    pname = "js";
    ipkg = "js/js.ipkg";
    inherit src;
    deps = [ "elab-util" "quantifiers-extra" ];
  };
}
