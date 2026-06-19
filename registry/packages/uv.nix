# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-uv

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-uv";
    rev = "e388bf34404410cbea14924dda7f7fcabc33b2a4";
    hash = "sha256-kVSSMP22JXPI5dPGgkJGK1N+kTLloETkgC2pEK73QOY=";  # hash-updated: 2026-06-19 16:30:11;  # hash-updated: 2026-05-02 03:10:14
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
