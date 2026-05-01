# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Z-snails/prettier

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "prettier";
  ipkg = "prettier.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Z-snails";
    repo = "prettier";
    rev = "main";
    hash = "sha256-hTJyfUJ6+Q32CDNJsByG7P6eP1bAJStEERLRGauStdA=";  # hash-updated: 2026-05-02 03:09:32
  };
  deps = [ ];
}
