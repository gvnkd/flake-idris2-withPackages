# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/bio-aeon/evince

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "bio-aeon";
    repo = "evince";
    rev = "main";
    hash = "sha256-lHUha/vGaRO9G0Xo4qLzVhBGsRzY4v8UoHs44Ijg/5E=";  # hash-updated: 2026-05-02 03:08:13
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
