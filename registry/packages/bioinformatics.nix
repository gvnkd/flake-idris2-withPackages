# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Matthew-Mosior/idris2-bioinformatics

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "ilex-fasta";
  ipkg = "fasta/ilex-fasta.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Matthew-Mosior";
    repo = "idris2-bioinformatics";
    rev = "c16240540ebedd2e89a9d371c209886ed1d1be4c";
    hash = "sha256-H00grbjyeaW7BOcMS7DKoK7L14WKyqPyC0XgYIByeZo=";  # hash-updated: 2026-06-19 16:27:21;  # hash-updated: 2026-05-02 03:07:43
  };
  deps = [ "async-epoll" "ilex" "ilex-streams" "streams-posix" ];
}
