# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-profiler

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "profiler";
  ipkg = "profiler.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-profiler";
    rev = "4cc28b478991d2d13d8505492e044006c5289720";
    hash = "sha256-mr/ExJ4lKss8SJqNto0c5Todjvh6Dxv74z6ZducTu08=";  # hash-updated: 2026-06-19 16:29:19;  # hash-updated: 2026-05-02 03:09:35
  };
  deps = [ "refined" ];
}
