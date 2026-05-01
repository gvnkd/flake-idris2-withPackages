# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://codeberg.org/tzemanovic/idris2-dep-graph

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "idris2-dep-graph";
  ipkg = "idris2-dep-graph.ipkg";
  src = builtins.fetchGit {
    url = "https://codeberg.org/tzemanovic/idris2-dep-graph";
    ref = "main";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
