# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-pack

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-pack";
    rev = "main";
    hash = "sha256-VL5dvRSuDY3ZXLs/uYl5QQNtCqprBec92F5vdYwwlxI=";  # hash-updated: 2026-05-02 03:09:26
  };
in
{
  pack = buildIdrisWithDocs {
    pname = "pack";
    ipkg = "pack.ipkg";
    inherit src;
  deps = [
    "elab-util"
    "filepath"
    "getopts"
    "ilex-toml"
  ];
  };
  pack-admin = buildIdrisWithDocs {
    pname = "pack-admin";
    ipkg = "pack-admin.ipkg";
    inherit src;
    deps = [
      "elab-util"
      "filepath"
      "getopts"
      "ilex-toml"
    ];
  };
}
