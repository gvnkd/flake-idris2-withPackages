# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-random-pure

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "random-pure";
  ipkg = "random-pure.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-random-pure";
    rev = "master";
    hash = "sha256-qth1LF6+/fWgqgLS36AcDamRq46816WfBCbi3kUDILQ=";  # hash-updated: 2026-05-02 03:09:39
  };
  deps = [
    "prettier"
  ];
}
