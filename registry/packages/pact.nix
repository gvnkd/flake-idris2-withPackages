# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/running-grass/idris2-pact

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "running-grass";
    repo = "idris2-pact";
    rev = "a37470d35a9abe73114035ca56bd735422fbbab6";
    hash = "sha256-NkbLGtY0lAai/NilcXGt65iK82guQI4CYvdprHtKaaY=";  # hash-updated: 2026-06-19 16:29:08;  # hash-updated: 2026-05-02 03:09:27
  };
in
{
  pact-api = buildIdrisWithDocs {
    pname = "pact-api";
    ipkg = "api/pact-api.ipkg";
    inherit src;
  deps = [ "apache-mime-types" "json" "pact-wai" ];
  };
  pact-client = buildIdrisWithDocs {
    pname = "pact-client";
    ipkg = "client/pact-client.ipkg";
    inherit src;
    deps = [ "http" "pact-api" ];
  };
  pact-server = buildIdrisWithDocs {
    pname = "pact-server";
    ipkg = "server/pact-server.ipkg";
    inherit src;
    deps = [ "pact-api" "pact-wai" ];
  };
  pact-wai = buildIdrisWithDocs {
    pname = "pact-wai";
    ipkg = "wai/pact-wai.ipkg";
    inherit src;
    deps = [ ];
  };
  pact-todomvc = buildIdrisWithDocs {
    pname = "pact-todomvc";
    ipkg = "todomvc/pact-todomvc.ipkg";
    inherit src;
    deps = [ "async-epoll" "json" "pact-api" "pact-client" "pact-server" "pact-wai" "streams-posix" ];
  };
}
