# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-async

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-async";
    rev = "b5d7caa9f73891886e76515d51be551201e4c026";
    hash = "sha256-3SBKxM8wbTtxwH/iarNTZ/oX68M3FdOmQZC208HKyWY=";  # hash-updated: 2026-06-19 16:27:17;  # hash-updated: 2026-05-02 03:06:40
  };
in
{
  async = buildIdrisWithDocs {
    pname = "async";
    ipkg = "async.ipkg";
    inherit src;
  deps = [ "array" "containers" "elin" "quantifiers-extra" ];
  };
  async-js = buildIdrisWithDocs {
    pname = "async-js";
    ipkg = "async-js/async-js.ipkg";
    inherit src;
    deps = [ "async" "js" ];
  };
  async-epoll = buildIdrisWithDocs {
    pname = "async-epoll";
    ipkg = "async-epoll/async-epoll.ipkg";
    inherit src;
    deps = [ "async-posix" "linux" ];
  };
  async-posix = buildIdrisWithDocs {
    pname = "async-posix";
    ipkg = "async-posix/async-posix.ipkg";
    inherit src;
    deps = [ "ansi" "async" "posix" ];
  };
  async-spec = buildIdrisWithDocs {
    pname = "async-spec";
    ipkg = "async-spec/async-spec.ipkg";
    inherit src;
    deps = [ "async" "prettier-ansi" "pretty-show" ];
  };
}
