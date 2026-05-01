# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Russoul/Idris2-Effect

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "effect";
  ipkg = "effect.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Russoul";
    repo = "Idris2-Effect";
    rev = "master";
    hash = "sha256-52rVYBfly6bRY6l48INum+l5kLIHBvoDpCc1veyofaw=";  # hash-updated: 2026-05-02 03:08:30
  };
  deps = [ ];
}
