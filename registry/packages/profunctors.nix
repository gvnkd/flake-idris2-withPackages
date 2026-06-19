# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kiana-S/idris2-profunctors

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "profunctors";
  ipkg = "profunctors.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kiana-S";
    repo = "idris2-profunctors";
    rev = "e862ef887f9dcdf90eacb1ca1c0a997d7a251135";
    hash = "sha256-fqAiBhlACZJ1VJkESkkd9yEzPmXxquq/9Myrzt+R9cY=";  # hash-updated: 2026-06-19 16:29:21;  # hash-updated: 2026-05-02 03:09:36
  };
  deps = [ ];
}
