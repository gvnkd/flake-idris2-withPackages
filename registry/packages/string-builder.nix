# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Z-snails/string-builder

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "string-builder";
  ipkg = "string-builder.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Z-snails";
    repo = "string-builder";
    rev = "6dfb5e0070274ead1b8fd4e1229b5254da7ddd15";
    hash = "sha256-BJexPLmkMX4mNShBlDzYUajCQ7iqsKyYjeBZmaKDR+8=";  # hash-updated: 2026-06-19 16:29:46;  # hash-updated: 2026-05-02 03:09:55
  };
  deps = [ ];
}
