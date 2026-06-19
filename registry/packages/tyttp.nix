# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kbertalan/tyttp

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "kbertalan";
    repo = "tyttp";
    rev = "8af0a3d6f37191dd36cc7f30a82af28bbcd82a9e";
    hash = "sha256-G2liKyLsI61coGkCAxASWpe5PDanrXrYwdUAjXgIvWA=";  # hash-updated: 2026-06-19 16:30:07;  # hash-updated: 2026-05-02 03:10:11
  };
in
{
  tyttp = buildIdrisWithDocs {
    pname = "tyttp";
    ipkg = "tyttp.ipkg";
    inherit src;
  deps = [ "apache-mime-types" "promise" ];
  };
  tyttp-adapter-node = buildIdrisWithDocs {
    pname = "tyttp-adapter-node";
    ipkg = "adapter-node/tyttp-adapter-node.ipkg";
    inherit src;
    deps = [ "apache-mime-types" "node" "promise" "tyttp" ];
  };
  tyttp-json = buildIdrisWithDocs {
    pname = "tyttp-json";
    ipkg = "json/tyttp-json.ipkg";
    inherit src;
    deps = [ "apache-mime-types" "elab-util" "json" "node" "promise" "sop" "tyttp" ];
  };
}
