# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/JankaGramofonomanka/idris-dependent-map

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "dependent-map";
  ipkg = "dependent-map.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "JankaGramofonomanka";
    repo = "idris-dependent-map";
    rev = "19718e6df489aeb42d5084da01013eed9acd7ffc";
    hash = "sha256-k5B14GzKVV1E9srncNBvEMZutN1LX+hYvQ24WZH5mZE=";  # hash-updated: 2026-06-19 16:27:47;  # hash-updated: 2026-05-02 03:07:59
  };
  deps = [ "dtypes" "hedgehog" ];
}
