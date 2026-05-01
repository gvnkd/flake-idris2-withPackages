# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/cont

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "cont";
  ipkg = "cont.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/cont";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
