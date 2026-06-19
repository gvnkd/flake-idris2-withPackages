# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/kuribas/idris-records

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "records";
  ipkg = "records.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "kuribas";
    repo = "idris-records";
    rev = "4a5784648d3f8b544e7a375431fa70698e8ed6fc";
    hash = "sha256-jW6FY48j/NN9BI6KQ/ZG5ArvMzzQhsQsNLoWKiZBwxw=";  # hash-updated: 2026-06-19 16:29:29;  # hash-updated: 2026-05-02 03:09:41
  };
  deps = [ ];
}
