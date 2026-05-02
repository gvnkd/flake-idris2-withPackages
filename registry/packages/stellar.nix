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
  deps = [ "algdata" "fs-utils" ];
  };
  stellar-http = buildIdrisWithDocs {
    pname = "stellar-http";
    ipkg = "http/stellar-http.ipkg";
    inherit src;
    deps = [ "continuation-monad" "fs-utils" "json-simple" "node" "stellar-api" "tyttp" "tyttp-adapter-node" ];
  };
  stellar-sql = buildIdrisWithDocs {
    pname = "stellar-sql";
    ipkg = "sql/stellar-sql.ipkg";
    inherit src;
    deps = [ "algdata" "json" "sqlite3" "sqlite3-rio" "stellar-api" ];
  };
}
