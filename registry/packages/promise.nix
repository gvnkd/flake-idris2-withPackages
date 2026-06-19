# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kbertalan/idris2-promise

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "promise";
  ipkg = "promise.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kbertalan";
    repo = "idris2-promise";
    rev = "0b1716525ee10ed3a4f0d7132107c83e88f8eb99";
    hash = "sha256-t4K96CWo79NGJkMS2/PtJW6MDKK4+slC8Q9XiSyw8Q8=";  # hash-updated: 2026-06-19 16:29:22;  # hash-updated: 2026-05-02 03:09:37
  };
  deps = [ ];
}
