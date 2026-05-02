# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-async-dom

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "async-dom";
  ipkg = "async-dom.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-async-dom";
    rev = "main";
    hash = "sha256-KSCwxaZkPUtrKo5ImamkpBPcl0vtB67/tcclQX8Me1Q=";  # hash-updated: 2026-05-02 03:07:41
  };
  deps = [ "async-js" "barbies" "css" "dom" "json-simple" "monocle" "streams" ];
}
