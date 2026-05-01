# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://gitlab.com/avidela/stellar

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitLab {
    owner = "avidela";
    repo = "stellar";
    rev = "main";
    hash = "sha256-1fBqxy2dhFD/SbDFWhF9Ah64mJCzl9cgmLeYQrwSWuY=";  # hash-updated: 2026-05-02 03:09:53
  };
in
{
  stellar-api = buildIdrisWithDocs {
    pname = "stellar-api";
    ipkg = "api/stellar-api.ipkg";
    inherit src;
  deps = [
    "algdata"
    "fs-utils"
  ];
  };
  stellar-http = buildIdrisWithDocs {
    pname = "stellar-http";
    ipkg = "http/stellar-http.ipkg";
    inherit src;
    deps = [
      "stellar-api"
      "tyttp"
      "node"
      "tyttp-adapter-node"
      "continuation-monad"
      "json-simple"
      "fs-utils"
    ];
  };
  stellar-sql = buildIdrisWithDocs {
    pname = "stellar-sql";
    ipkg = "sql/stellar-sql.ipkg";
    inherit src;
    deps = [
      "sqlite3"
      "sqlite3-rio"
      "algdata"
      "stellar-api"
      "json"
    ];
  };
}
