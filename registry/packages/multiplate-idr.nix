# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Z-snails/multiplate-idr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "multiplate";
  ipkg = "multiplate.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Z-snails";
    repo = "multiplate-idr";
    rev = "main";
    hash = "sha256-oke0jn98m0I0Vk3YuuOI1KAZcQ33Dgez5FGnT7dM3ak=";  # hash-updated: 2026-05-02 03:09:21
  };
  deps = [ ];
}
