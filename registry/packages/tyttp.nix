# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kbertalan/tyttp

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "kbertalan";
    repo = "tyttp";
    rev = "main";
    hash = "sha256-G2liKyLsI61coGkCAxASWpe5PDanrXrYwdUAjXgIvWA=";  # hash-updated: 2026-05-02 03:10:11
  };
in
{
  tyttp = buildIdrisWithDocs {
    pname = "tyttp";
    ipkg = "tyttp.ipkg";
    inherit src;
  deps = [
    "apache-mime-types"
    "promise"
  ];
  };
  tyttp-adapter-node = buildIdrisWithDocs {
    pname = "tyttp-adapter-node";
    ipkg = "adapter-node/tyttp-adapter-node.ipkg";
    inherit src;
    deps = [
      "apache-mime-types"
      "node"
      "promise"
      "tyttp"
    ];
  };
  tyttp-json = buildIdrisWithDocs {
    pname = "tyttp-json";
    ipkg = "json/tyttp-json.ipkg";
    inherit src;
    deps = [
      "tyttp"
      "promise"
      "json"
      "sop"
      "elab-util"
      "apache-mime-types"
      "node"
    ];
  };
}
