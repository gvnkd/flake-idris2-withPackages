# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~thatonelutenist/Structures

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "structures";
  ipkg = "structures.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~thatonelutenist/Structures";
    ref = "trunk";
    rev = "cd11a19794a139ccb14441c4d522de3d2b201083";
    allRefs = true;
  };
  deps = [ ];
}
