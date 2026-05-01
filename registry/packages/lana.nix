# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/lana

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "lana";
  ipkg = "lana.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/lana";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
