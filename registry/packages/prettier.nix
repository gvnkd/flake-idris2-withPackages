# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Z-snails/prettier

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "prettier";
  ipkg = "prettier.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Z-snails";
    repo = "prettier";
    rev = "666b4e6ba397e332deb4076d56ce745c8fb542a0";
    hash = "sha256-hTJyfUJ6+Q32CDNJsByG7P6eP1bAJStEERLRGauStdA=";  # hash-updated: 2026-06-19 16:29:15;  # hash-updated: 2026-05-02 03:09:32
  };
  deps = [ ];
}
