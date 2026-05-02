# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-regex

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "regex";
  ipkg = "regex.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-regex";
    rev = "master";
    hash = "sha256-lLPxJzQp0JNYG045f9xnOxQw2VSxh/KR7eefdsCpMp4=";  # hash-updated: 2026-05-02 03:09:44
  };
  deps = [ "best-alternative" "collection-utils" "elab-util" "i-hate-parens" ];
}
