# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kiana-S/idris2-ratio

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "ratio";
  ipkg = "ratio.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kiana-S";
    repo = "idris2-ratio";
    rev = "main";
    hash = "sha256-hk03nilUPs64o8lDLHLAoy3Ccp9pZs0OKNz9/npYROQ=";  # hash-updated: 2026-05-02 03:09:40
  };
  deps = [ ];
}
