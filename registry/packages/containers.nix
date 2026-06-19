# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/idris2-containers

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "containers";
  ipkg = "containers.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-containers";
    rev = "cd7208400beb9346ee186c10c75b359fc6f11b66";
    hash = "sha256-mFS8N3+AqhYb4chgLIv4Dr+dILoysc6gUeiP2u6fnGI=";  # hash-updated: 2026-06-19 16:27:34;  # hash-updated: 2026-05-02 03:07:51
  };
  deps = [ "array" "elab-util" "hashable" "ref1" ];
}
