# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-pack

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-pack";
    rev = "3174b1d383addcbac6ff8a1c9cebcd4fd19ce396";
    hash = "sha256-XiKWFJDW/rZDWg6Nw5yk/m1Vrl2JyLtdXr74CIqtDww=";  # hash-updated: 2026-06-19 16:29:06;  # hash-updated: 2026-05-02 03:09:26
  };
in
{
  pack = buildIdrisWithDocs {
    pname = "pack";
    ipkg = "pack.ipkg";
    inherit src;
  deps = [ "elab-util" "filepath" "getopts" "idris2" "ilex-toml" ];
  };
  pack-admin = buildIdrisWithDocs {
    pname = "pack-admin";
    ipkg = "pack-admin.ipkg";
    inherit src;
    deps = [ "elab-util" "filepath" "getopts" "idris2" "ilex-toml" ];
  };
}
