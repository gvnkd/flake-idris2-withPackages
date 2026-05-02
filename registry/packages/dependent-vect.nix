# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-dependent-vect

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "dependent-vect";
  ipkg = "dependent-vect.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-dependent-vect";
    rev = "master";
    hash = "sha256-O0r4CyWggt0lnPYaMCyznEs6I+0U7SMrzWYdp4EupSg=";  # hash-updated: 2026-05-02 03:08:00
  };
  deps = [ "fin-lizzie" ];
}
