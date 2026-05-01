# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-golden-runner-helper

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "golden-runner-helper";
  ipkg = "golden-runner-helper.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-golden-runner-helper";
    rev = "master";
    hash = "sha256-B0T+zOANqKVtrdoeOSZo6cMrA7DId7CrCMqLDy2etm4=";  # hash-updated: 2026-05-02 03:08:22
  };
  deps = [ ];
}
