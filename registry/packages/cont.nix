# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/cont

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "cont";
  ipkg = "cont.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/cont";
    ref = "master";
    rev = "5ca3c85f6356c1c4b860ac7cf65caa9b39f0bf21";
    allRefs = true;
  };
  deps = [ "utf8" ];
}
