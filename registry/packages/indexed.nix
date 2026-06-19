# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/mattpolzin/idris-indexed

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "indexed";
  ipkg = "indexed.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "mattpolzin";
    repo = "idris-indexed";
    rev = "c99707f1db2efa2e97c465b16b525cb79b28f349";
    hash = "sha256-k31KQy5av3KwwXcAB8t6VgYWR8ukS8+k43MnQ1kG384=";  # hash-updated: 2026-06-19 16:28:40;  # hash-updated: 2026-05-02 03:09:07
  };
  deps = [ ];
}
