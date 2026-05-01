# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/madman-bob/idris2-xml

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "xml";
  ipkg = "xml.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "madman-bob";
    repo = "idris2-xml";
    rev = "main";
    hash = "sha256-9L0Cb+xr712ejB8iIHAy5pbpDE5eWhhOszXhBcdOEp0=";  # hash-updated: 2026-05-02 03:10:17
  };
  deps = [ ];
}
