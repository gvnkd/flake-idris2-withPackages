# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-cyby-draw

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-cyby-draw";
    rev = "297afb87cf5530391605b855440d2275951b1164";
    hash = "sha256-dHcEwvA/czL33Kxo1YhmPS49QVSXUIHfHQAGI8vdm/c=";  # hash-updated: 2026-06-19 16:27:44;  # hash-updated: 2026-05-02 03:07:57
  };
in
{
  cyby-css = buildIdrisWithDocs {
    pname = "cyby-css";
    ipkg = "cyby-css/cyby-css.ipkg";
    inherit src;
  deps = [ "async-dom" "chem" "css" ];
  };
  cyby-draw = buildIdrisWithDocs {
    pname = "cyby-draw";
    ipkg = "cyby-draw.ipkg";
    inherit src;
    deps = [ "array" "async-dom" "chem" "containers" "cyby-css" "pretty-show" "svg" ];
  };
}
