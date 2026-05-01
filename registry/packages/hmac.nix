# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/hmac

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "hmac";
  ipkg = "hmac.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/hmac";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
