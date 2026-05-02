# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/scram

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "scram";
  ipkg = "scram.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/scram";
    ref = "master";
    rev = "f02823727535bbe673bf4bd40f7a5d1fefc3923e";
    allRefs = true;
  };
  deps = [ "base64" "hmac" "string-search" "utf8" ];
}
