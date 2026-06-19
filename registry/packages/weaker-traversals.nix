# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-weaker-traversals

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "weaker-traversals";
  ipkg = "weaker-traversals.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-weaker-traversals";
    rev = "ad37eecdc705951da22369fbe255174c0423b0b7";
    hash = "sha256-N3zJa/r90/mg+DShBlIGPEOtWugqQEj6Gyxyoq60+bc=";  # hash-updated: 2026-06-19 16:30:12;  # hash-updated: 2026-05-02 03:10:15
  };
  deps = [ ];
}
