# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/scram

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "scram";
  ipkg = "scram.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/scram";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
