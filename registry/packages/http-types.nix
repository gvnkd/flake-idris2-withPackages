# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-http-types

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-http-types";
    rev = "2230788ece17b4360c62940837c1f685e9420a90";
    hash = "sha256-oToeP9ZRRWV/c7yVFxuf65fxqM7RZuiqncSOv3PnSM0=";  # hash-updated: 2026-06-19 16:28:30;  # hash-updated: 2026-05-02 03:08:29
  };
in
{
  http-client-api = buildIdrisWithDocs {
    pname = "http-client-api";
    ipkg = "http-client-api/http-client-api.ipkg";
    inherit src;
  deps = [ "async-dom" "async-js" "dom" "http-types" ];
  };
  http-types = buildIdrisWithDocs {
    pname = "http-types";
    ipkg = "http-types.ipkg";
    inherit src;
    deps = [ "ilex" "json-simple" ];
  };
  http-server-api = buildIdrisWithDocs {
    pname = "http-server-api";
    ipkg = "http-server-api/http-server-api.ipkg";
    inherit src;
    deps = [ "http-types" "streams-posix" ];
  };
}
