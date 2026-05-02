# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://git.sr.ht/~janus/base64

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "base64";
  ipkg = "base64.ipkg";
  src = builtins.fetchGit {
    url = "https://git.sr.ht/~janus/base64";
    ref = "master";
    rev = "f749111b3a4ffa2b0c39d16153bc5670e7347ef9";
    allRefs = true;
  };
  deps = [ "array" "utf8" ];
}
