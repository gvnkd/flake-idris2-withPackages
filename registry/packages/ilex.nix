# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-ilex

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-ilex";
    rev = "main";
    hash = "sha256-8IqmxwZYeGtPepj4RrMBnSYj9iBSSNTnOSbt6WN20Y0=";  # hash-updated: 2026-05-02 03:09:05
  };
in
{
  ilex = buildIdrisWithDocs {
    pname = "ilex";
    ipkg = "ilex.ipkg";
    inherit src;
  deps = [
    "elab-util"
    "algebra"
    "array"
    "bytestring"
    "ilex-core"
    "refined"
  ];
  };
  ilex-core = buildIdrisWithDocs {
    pname = "ilex-core";
    ipkg = "core/ilex-core.ipkg";
    inherit src;
    deps = [
      "elab-util"
      "bytestring"
    ];
  };
  ilex-debug = buildIdrisWithDocs {
    pname = "ilex-debug";
    ipkg = "debug/ilex-debug.ipkg";
    inherit src;
    deps = [
      "ilex"
      "elab-pretty"
    ];
  };
  ilex-streams = buildIdrisWithDocs {
    pname = "ilex-streams";
    ipkg = "streams/ilex-streams.ipkg";
    inherit src;
    deps = [
      "ilex"
      "streams"
      "elin"
    ];
  };
  ilex-json = buildIdrisWithDocs {
    pname = "ilex-json";
    ipkg = "json/ilex-json.ipkg";
    inherit src;
    deps = [
      "ilex"
    ];
  };
  ilex-toml = buildIdrisWithDocs {
    pname = "ilex-toml";
    ipkg = "toml/ilex-toml.ipkg";
    inherit src;
    deps = [
      "ilex"
      "refined"
    ];
  };
}
