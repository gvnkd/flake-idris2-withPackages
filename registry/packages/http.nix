# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/idris-community/idris2-http

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "http";
  ipkg = "http.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "idris-community";
    repo = "idris2-http";
    rev = "master";
    hash = "sha256-yudPQUPAuMuBlyHac2OZW49EEU6Y11zxKYtvWzE1bLA=";  # hash-updated: 2026-05-02 03:08:28
  };
  deps = [ "base64" "elab-util" "sop" "tls" ];
}
