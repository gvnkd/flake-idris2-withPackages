# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kbertalan/idris2-promise

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "promise";
  ipkg = "promise.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kbertalan";
    repo = "idris2-promise";
    rev = "main";
    hash = "sha256-t4K96CWo79NGJkMS2/PtJW6MDKK4+slC8Q9XiSyw8Q8=";  # hash-updated: 2026-05-02 03:09:37
  };
  deps = [ ];
}
