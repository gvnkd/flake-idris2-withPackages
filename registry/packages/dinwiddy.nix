# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/bobbbay/dinwiddy

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "dinwiddy";
  ipkg = "dinwiddy.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "bobbbay";
    repo = "dinwiddy";
    rev = "61a81c55e48e4b7b551fb7493d623cb7659a37ce";
    hash = "sha256-4Cy9W+OsGNIbwBqMBOk4SLoXBeJN82LZ3SILfr3eRU4=";  # hash-updated: 2026-06-19 16:27:51;  # hash-updated: 2026-05-02 03:08:02
  };
  deps = [ ];
}
