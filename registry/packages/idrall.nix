# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/alexhumphreys/idrall

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "idrall";
  ipkg = "idrall.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "alexhumphreys";
    repo = "idrall";
    rev = "main";
    hash = "sha256-/9/R1xAFIAg7uMpCsRj5RLbPfBzjvEI0MGPmGtVm8+Q=";  # hash-updated: 2026-05-02 03:08:30
  };
  deps = [ ];
}
