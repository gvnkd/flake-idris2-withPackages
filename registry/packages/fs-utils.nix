# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://gitlab.com/avidela/fs-utils

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "fs-utils";
  ipkg = "fs-utils.ipkg";
  src = pkgs.fetchFromGitLab {
    owner = "avidela";
    repo = "fs-utils";
    rev = "main";
    hash = "sha256-69TBPJ17D0SqZmleqgep5JcLZC3M3air6U2c4wpujhg=";  # hash-updated: 2026-05-02 03:08:21
  };
  deps = [ ];
}
