# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-ilex

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-ilex";
    rev = "de44d580a584dfbbc6269a60ec69eac2124d133e";
    hash = "sha256-PAjYgLcfeqmgqQZMiBs/cJcQeSBetbYqIJmUzlGeE6c=";  # hash-updated: 2026-06-19 16:28:37;  # hash-updated: 2026-05-02 03:09:05
  };
in
{
  ilex = buildIdrisWithDocs {
    pname = "ilex";
    ipkg = "ilex.ipkg";
    inherit src;
  deps = [ "algebra" "array" "bytestring" "elab-util" "ilex-core" "refined" ];
  };
  ilex-core = buildIdrisWithDocs {
    pname = "ilex-core";
    ipkg = "core/ilex-core.ipkg";
    inherit src;
    deps = [ "bytestring" "elab-util" ];
  };
  ilex-debug = buildIdrisWithDocs {
    pname = "ilex-debug";
    ipkg = "debug/ilex-debug.ipkg";
    inherit src;
    deps = [ "elab-pretty" "ilex" ];
  };
  ilex-streams = buildIdrisWithDocs {
    pname = "ilex-streams";
    ipkg = "streams/ilex-streams.ipkg";
    inherit src;
    deps = [ "elin" "ilex" "streams" ];
  };
  ilex-json = buildIdrisWithDocs {
    pname = "ilex-json";
    ipkg = "json/ilex-json.ipkg";
    inherit src;
    deps = [ "ilex" ];
  };
  ilex-toml = buildIdrisWithDocs {
    pname = "ilex-toml";
    ipkg = "toml/ilex-toml.ipkg";
    inherit src;
    deps = [ "ilex" "refined" ];
  };
}
