# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-streams

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-streams";
    rev = "dd56316d102c4736ba24f47bea72fc3a9008585f";
    hash = "sha256-PlvyUE87HIWORrO2fhJDx+cj0Nn4zpJHeNYItjOCDHs=";  # hash-updated: 2026-06-19 16:29:45;  # hash-updated: 2026-05-02 03:09:54
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
