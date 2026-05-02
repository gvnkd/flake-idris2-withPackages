# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://codeberg.org/berg4478/idris2-text-markdown

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "markdown";
  ipkg = "markdown.ipkg";
  src = builtins.fetchGit {
    url = "https://codeberg.org/berg4478/idris2-text-markdown";
    ref = "main";
    rev = "0cd58c79d6112756557eb8f0785342dbbef00eb9";
    allRefs = true;
  };
  deps = [ ];
}
