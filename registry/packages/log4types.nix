# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/bio-aeon/log4types

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "bio-aeon";
    repo = "log4types";
    rev = "217515f534bc1cb4b2dbfa4ed7f245c1fd376694";
    hash = "sha256-QZrv+/jm8odiayZlBhYsQh3Fj9IV8WdIX28kadQpa1M=";  # hash-updated: 2026-06-19 16:28:50;  # hash-updated: 2026-05-02 03:09:13
  };
in
{
  log4types = buildIdrisWithDocs {
    pname = "log4types";
    ipkg = "log4types/log4types.ipkg";
    inherit src;
  deps = [ "log4types-core" ];
  };
  log4types-core = buildIdrisWithDocs {
    pname = "log4types-core";
    ipkg = "log4types-core/log4types-core.ipkg";
    inherit src;
    deps = [ ];
  };
  log4types-json = buildIdrisWithDocs {
    pname = "log4types-json";
    ipkg = "log4types-json/log4types-json.ipkg";
    inherit src;
    deps = [ "log4types-core" ];
  };
}
