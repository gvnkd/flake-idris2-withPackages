# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-ref1

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "ref1";
  ipkg = "ref1.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-ref1";
    rev = "main";
    hash = "sha256-YS/JV/c3Ai5kU1Y1jfJYPzbF2W3o0YysdafC8+Xp4Bw=";  # hash-updated: 2026-05-02 03:09:42
  };
  deps = [ ];
}
