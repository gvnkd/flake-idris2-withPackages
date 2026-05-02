# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-streams

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-streams";
    rev = "main";
    hash = "sha256-PlvyUE87HIWORrO2fhJDx+cj0Nn4zpJHeNYItjOCDHs=";  # hash-updated: 2026-05-02 03:09:54
  };
in
{
  streams = buildIdrisWithDocs {
    pname = "streams";
    ipkg = "streams.ipkg";
    inherit src;
  deps = [ "async" "bytestring" "elin" ];
  };
  streams-posix = buildIdrisWithDocs {
    pname = "streams-posix";
    ipkg = "posix/streams-posix.ipkg";
    inherit src;
    deps = [ "async-posix" "filepath" "streams" ];
  };
}
