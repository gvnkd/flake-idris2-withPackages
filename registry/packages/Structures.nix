# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~thatonelutenist/Structures

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "structures";
  ipkg = "structures.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~thatonelutenist/Structures";
    ref = "trunk";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
