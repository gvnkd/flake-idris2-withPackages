# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/utf8

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "utf8";
  ipkg = "utf8.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/utf8";
    ref = "master";
    rev = "f3584f3cf7ac09bd566b5cc5301192db272d03c9";
    allRefs = true;
  };
  deps = [ "array" ];
}
