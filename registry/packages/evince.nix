# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/bio-aeon/evince

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "bio-aeon";
    repo = "evince";
    rev = "d6d2311e9ed95a140608e3a67fbfe8652e383389";
    hash = "sha256-yztyJjQzphsWre3zbNUdFhY7C86KtE7LOn7g03/uMII=";  # hash-updated: 2026-06-19 16:28:07;  # hash-updated: 2026-05-02 03:08:13
  };
in
{
  evince = buildIdrisWithDocs {
    pname = "evince";
    ipkg = "evince/evince.ipkg";
    inherit src;
  deps = [ "pretty-show" ];
  };
  evince-hedgehog = buildIdrisWithDocs {
    pname = "evince-hedgehog";
    ipkg = "evince-hedgehog/evince-hedgehog.ipkg";
    inherit src;
    deps = [ "evince" "hedgehog" ];
  };
}
