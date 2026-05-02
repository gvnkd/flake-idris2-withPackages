# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/buf-conn

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "buf-conn";
  ipkg = "buf-conn.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/buf-conn";
    ref = "master";
    rev = "6423008862b921f92bcd582de80a6488097d1591";
    allRefs = true;
  };
  deps = [ "cont" ];
}
