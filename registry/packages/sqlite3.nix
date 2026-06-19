# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-sqlite3

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-sqlite3";
    rev = "9241b497a01c477c3a4014b9487dee300d83fe77";
    hash = "sha256-EIQjpthHOLoa2nTsqF1OYpdhMehBfI3SB6LD2oMXVXk=";  # hash-updated: 2026-06-19 16:29:43;  # hash-updated: 2026-05-02 03:09:52
  };
in
{
  sqlite3 = buildIdrisWithDocs {
    pname = "sqlite3";
    ipkg = "sqlite3.ipkg";
    inherit src;
  deps = [ "bytestring" "elab-util" "quantifiers-extra" ];
  };
  sqlite3-streams = buildIdrisWithDocs {
    pname = "sqlite3-streams";
    ipkg = "sqlite3-streams/sqlite3-streams.ipkg";
    inherit src;
    deps = [ "sqlite3" "streams" ];
  };
}
