# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-cyby-draw

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-cyby-draw";
    rev = "main";
    hash = "sha256-/j29XRYItMK1E7tEQNsw9uZiP9qAmkGi9bEo24ofTbk=";  # hash-updated: 2026-05-02 03:07:57
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
