# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kasiaMarek/TyRE

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "tyre";
  ipkg = "tyre.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kasiaMarek";
    repo = "TyRE";
    rev = "main";
    hash = "sha256-WJyS9IXHGopouVpsL7IiUMQ79K2SbAlDD/0P+PTy0es=";  # hash-updated: 2026-05-02 03:10:10
  };
  deps = [ ];
}
