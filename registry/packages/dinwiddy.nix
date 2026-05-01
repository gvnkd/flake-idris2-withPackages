# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/bobbbay/dinwiddy

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "dinwiddy";
  ipkg = "dinwiddy.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "bobbbay";
    repo = "dinwiddy";
    rev = "main";
    hash = "sha256-4Cy9W+OsGNIbwBqMBOk4SLoXBeJN82LZ3SILfr3eRU4=";  # hash-updated: 2026-05-02 03:08:02
  };
  deps = [ ];
}
