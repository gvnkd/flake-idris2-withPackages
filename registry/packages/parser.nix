# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-parser

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-parser";
    rev = "main";
    hash = "sha256-FU3XgtyVN5oh8JEu6MOx19H1eN2t99JAi3Dz25ZaSxc=";  # hash-updated: 2026-05-02 03:09:29
  };
in
{
  parser = buildIdrisWithDocs {
    pname = "parser";
    ipkg = "parser.ipkg";
    inherit src;
  deps = [
    "elab-util"
    "bytestring"
    "ilex-core"
  ];
  };
  parser-show = buildIdrisWithDocs {
    pname = "parser-show";
    ipkg = "show/parser-show.ipkg";
    inherit src;
    deps = [
      "parser"
      "prettier"
    ];
  };
  parser-tsv = buildIdrisWithDocs {
    pname = "parser-tsv";
    ipkg = "tsv/parser-tsv.ipkg";
    inherit src;
    deps = [
      "parser"
      "elab-util"
    ];
  };
  parser-toml = buildIdrisWithDocs {
    pname = "parser-toml";
    ipkg = "toml/parser-toml.ipkg";
    inherit src;
    deps = [
      "parser"
      "refined"
    ];
  };
  parser-webidl = buildIdrisWithDocs {
    pname = "parser-webidl";
    ipkg = "webidl/parser-webidl.ipkg";
    inherit src;
    deps = [
      "parser"
      "refined"
      "sop"
    ];
  };
  parser-json = buildIdrisWithDocs {
    pname = "parser-json";
    ipkg = "json/parser-json.ipkg";
    inherit src;
    deps = [
      "parser"
    ];
  };
}
