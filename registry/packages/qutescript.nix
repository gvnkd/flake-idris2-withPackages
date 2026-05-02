# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-qutescript

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "qutescript";
  ipkg = "qutescript.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-qutescript";
    rev = "main";
    hash = "sha256-W3uwjs18LxoLx+ujTHVI89J2p6REuBS4NOE763OtIgM=";  # hash-updated: 2026-05-02 03:09:38
  };
  deps = [ "elab-util" "filepath" "rio" ];
}
