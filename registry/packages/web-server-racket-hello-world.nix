# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/web-server-racket-hello-world

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "web-server-racket-hello-world";
  ipkg = "web-server-racket-hello-world.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/web-server-racket-hello-world";
    ref = "master";
    allRefs = true;
  };
  deps = [ ];  # TODO: Add Idris dependencies
  meta.broken = true;
}
