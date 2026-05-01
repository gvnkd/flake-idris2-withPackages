# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/buf-conn

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "buf-conn";
  ipkg = "buf-conn.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/buf-conn";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
