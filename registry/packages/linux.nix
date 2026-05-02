# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-linux

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-linux";
    rev = "main";
    hash = "sha256-EyEcUqhJwTKdNwF1Rl18C4KROpt8jqXJo/tFQMFYke0=";  # hash-updated: 2026-05-02 03:09:12
  };
in
{
  linux = buildIdrisWithDocs {
    pname = "linux";
    ipkg = "linux/linux.ipkg";
    inherit src;
  deps = [ "posix" ];
  };
  posix = buildIdrisWithDocs {
    pname = "posix";
    ipkg = "posix/posix.ipkg";
    inherit src;
    deps = [ "bytestring" "cptr" "elab-util" "elin" "finite" ];
  };
}
