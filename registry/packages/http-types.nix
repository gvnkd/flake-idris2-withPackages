# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-http-types

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-http-types";
    rev = "main";
    hash = "sha256-cpWi0RHursxxVnHA6GG4qQvPHShVBbMlpi9LunD2pWg=";  # hash-updated: 2026-05-02 03:08:29
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
