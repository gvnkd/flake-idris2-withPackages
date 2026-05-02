# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/JankaGramofonomanka/idris-dependent-map

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "dependent-map";
  ipkg = "dependent-map.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "JankaGramofonomanka";
    repo = "idris-dependent-map";
    rev = "master";
    hash = "sha256-k5B14GzKVV1E9srncNBvEMZutN1LX+hYvQ24WZH5mZE=";  # hash-updated: 2026-05-02 03:07:59
  };
  deps = [ "dtypes" "hedgehog" ];
}
