# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/JankaGramofonomanka/idris-compiler-tools

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "control-flow";
  ipkg = "control-flow/control-flow.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "JankaGramofonomanka";
    repo = "idris-compiler-tools";
    rev = "master";
    hash = "sha256-3oqfV8PyefJz+ym/QkejSMeUgSktF3zzto6yiv/J41g=";  # hash-updated: 2026-05-02 03:07:50
  };
  deps = [
    "theory"
  ];
}
