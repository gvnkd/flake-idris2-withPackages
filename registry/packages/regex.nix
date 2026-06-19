# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-regex

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "regex";
  ipkg = "regex.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-regex";
    rev = "976ab9c3a144d614e4467f57bd567d1d5357e995";
    hash = "sha256-lLPxJzQp0JNYG045f9xnOxQw2VSxh/KR7eefdsCpMp4=";  # hash-updated: 2026-06-19 16:29:33;  # hash-updated: 2026-05-02 03:09:44
  };
  deps = [ "best-alternative" "collection-utils" "elab-util" "i-hate-parens" ];
}
