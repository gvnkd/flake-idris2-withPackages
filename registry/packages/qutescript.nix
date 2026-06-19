# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-qutescript

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "qutescript";
  ipkg = "qutescript.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-qutescript";
    rev = "0c52c5edaddd6fca7006c3cc50df5ccca330f134";
    hash = "sha256-W3uwjs18LxoLx+ujTHVI89J2p6REuBS4NOE763OtIgM=";  # hash-updated: 2026-06-19 16:29:25;  # hash-updated: 2026-05-02 03:09:38
  };
  deps = [ "elab-util" "filepath" "rio" ];
}
