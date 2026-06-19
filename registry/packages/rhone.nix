# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-rhone

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "rhone";
  ipkg = "rhone.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-rhone";
    rev = "e652d56901ebfea588dbdc3316df85200f232d57";
    hash = "sha256-XBjI/axBTKFTHIra0nGNwRal2qSiecfD7WJCKkDIYYk=";  # hash-updated: 2026-06-19 16:29:37;  # hash-updated: 2026-05-02 03:09:48
  };
  deps = [ "quantifiers-extra" ];
}
