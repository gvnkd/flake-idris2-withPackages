# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/dannypsnl/control-spec

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "control-spec";
  ipkg = "control-spec.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "dannypsnl";
    repo = "control-spec";
    rev = "main";
    hash = "sha256-OS8lRBZGHAp1fr6rK3UR8jVJVLgIsgIObIjUo8/S3c0=";  # hash-updated: 2026-05-02 03:07:52
  };
  deps = [ ];
}
