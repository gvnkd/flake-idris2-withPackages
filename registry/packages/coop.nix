# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-coop

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "coop";
  ipkg = "coop.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-coop";
    rev = "dd41cc8dc9d9d0757a23399f0a15df3e230a6695";
    hash = "sha256-MuP583CEKeGXnQABOZUC54fG8NTjnLoXskEq8t0TqfE=";  # hash-updated: 2026-06-19 16:27:37;  # hash-updated: 2026-05-02 03:07:53
  };
  deps = [ "mtl-tuple-impls" "tailrec" "time-for-sleep" ];
}
