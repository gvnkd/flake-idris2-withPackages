# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-cptr

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "cptr";
  ipkg = "cptr.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-cptr";
    rev = "63f224d52af5c5655f022fb9c9a6edd34feefd50";
    hash = "sha256-ONAaY/h1HPUaNaoEvdb8M3Lfh6CgN+eAqAfz0neW5ls=";  # hash-updated: 2026-06-19 16:27:39;  # hash-updated: 2026-05-02 03:07:55
  };
  deps = [ "array" "elin" ];
}
