# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-uv

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-uv";
    rev = "main";
    hash = "sha256-kVSSMP22JXPI5dPGgkJGK1N+kTLloETkgC2pEK73QOY=";  # hash-updated: 2026-05-02 03:10:14
  };
in
{
  uv = buildIdrisWithDocs {
    pname = "uv";
    ipkg = "uv.ipkg";
    inherit src;
  deps = [ "bytestring" "containers" "elab-util" "quantifiers-extra" "uv-data" ];
  };
  uv-data = buildIdrisWithDocs {
    pname = "uv-data";
    ipkg = "data/uv-data.ipkg";
    inherit src;
    deps = [ "elab-util" ];
  };
}
