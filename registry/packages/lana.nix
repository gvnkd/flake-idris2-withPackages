# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/lana

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "lana";
  ipkg = "lana.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/lana";
    ref = "master";
    rev = "15301789fed2985cbe1d31bb862731ba8de33b00";
    allRefs = true;
  };
  deps = [ "finite" "json" "json-simple" ];  # TODO: Add Idris dependencies
}
