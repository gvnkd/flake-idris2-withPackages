# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-golden-runner-helper

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "golden-runner-helper";
  ipkg = "golden-runner-helper.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-golden-runner-helper";
    rev = "7178ee86f2dde575e2c2bfb2ed4a69a1724eefa2";
    hash = "sha256-B0T+zOANqKVtrdoeOSZo6cMrA7DId7CrCMqLDy2etm4=";  # hash-updated: 2026-06-19 16:28:22;  # hash-updated: 2026-05-02 03:08:22
  };
  deps = [ ];
}
