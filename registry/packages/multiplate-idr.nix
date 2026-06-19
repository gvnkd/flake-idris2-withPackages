# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Z-snails/multiplate-idr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "multiplate";
  ipkg = "multiplate.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Z-snails";
    repo = "multiplate-idr";
    rev = "601d865f1fc74b783879b50d17ffd2a949def902";
    hash = "sha256-oke0jn98m0I0Vk3YuuOI1KAZcQ33Dgez5FGnT7dM3ak=";  # hash-updated: 2026-06-19 16:29:00;  # hash-updated: 2026-05-02 03:09:21
  };
  deps = [ ];
}
