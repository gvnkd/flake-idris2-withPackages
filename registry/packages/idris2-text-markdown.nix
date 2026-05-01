# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://codeberg.org/berg4478/idris2-text-markdown

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "markdown";
  ipkg = "markdown.ipkg";
  src = builtins.fetchGit {
    url = "https://codeberg.org/berg4478/idris2-text-markdown";
    ref = "main";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
