# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://codeberg.org/tzemanovic/idris2-dep-graph

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "idris2-dep-graph";
  ipkg = "idris2-dep-graph.ipkg";
  src = builtins.fetchGit {
    url = "https://codeberg.org/tzemanovic/idris2-dep-graph";
    ref = "main";
    rev = "c7a81006a1eddc2ed05708004310755568c8beff";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
}
