# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/hmac

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "hmac";
  ipkg = "hmac.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/hmac";
    ref = "master";
    rev = "14dbc91cb3e84dcd70cdda8efe8e48e97f3fb8f5";
    allRefs = true;
  };
  deps = [ "hash" ];
}
