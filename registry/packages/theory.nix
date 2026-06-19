# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/JankaGramofonomanka/idris-theory

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "theory";
  ipkg = "theory.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "JankaGramofonomanka";
    repo = "idris-theory";
    rev = "ff2ec3487bfb70746173cdafda09ee55418a63f0";
    hash = "sha256-5c1fp5t8YLy9qesV8oJr2e38Qv9ma1bwvF5W5ZnHekc=";  # hash-updated: 2026-06-19 16:29:58;  # hash-updated: 2026-05-02 03:10:03
  };
  deps = [ ];
}
