# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kiana-S/idris2-profunctors

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "profunctors";
  ipkg = "profunctors.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kiana-S";
    repo = "idris2-profunctors";
    rev = "main";
    hash = "sha256-fqAiBhlACZJ1VJkESkkd9yEzPmXxquq/9Myrzt+R9cY=";  # hash-updated: 2026-05-02 03:09:36
  };
  deps = [ ];
}
