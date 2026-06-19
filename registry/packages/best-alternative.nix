# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-best-alternative

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "best-alternative";
  ipkg = "best-alternative.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-best-alternative";
    rev = "7b084aa829c7eaa5ce608ceca6b486256436fdda";
    hash = "sha256-eTVX+sQb1J4ExapVHqG65OUij1Peg5glsrnqq08jtoo=";  # hash-updated: 2026-06-19 16:27:20;  # hash-updated: 2026-05-02 03:07:42
  };
  deps = [ ];
}
