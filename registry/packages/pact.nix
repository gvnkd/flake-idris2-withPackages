# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/running-grass/idris2-pact

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "running-grass";
    repo = "idris2-pact";
    rev = "main";
    hash = "sha256-NkbLGtY0lAai/NilcXGt65iK82guQI4CYvdprHtKaaY=";  # hash-updated: 2026-05-02 03:09:27
  };
in
{
  pact-api = buildIdrisWithDocs {
    pname = "pact-api";
    ipkg = "api/pact-api.ipkg";
    inherit src;
  deps = [
    "json"
    "pact-wai"
    "apache-mime-types"
  ];
  };
  pact-client = buildIdrisWithDocs {
    pname = "pact-client";
    ipkg = "client/pact-client.ipkg";
    inherit src;
    deps = [
      "pact-api"
      "http"
    ];
  };
  pact-server = buildIdrisWithDocs {
    pname = "pact-server";
    ipkg = "server/pact-server.ipkg";
    inherit src;
    deps = [
      "pact-wai"
      "pact-api"
    ];
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
    deps = [
      "streams-posix"
      "async-epoll"
      "json"
      "pact-api"
      "pact-wai"
      "pact-server"
      "pact-client"
    ];
  };
}
