# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/madman-bob/idris2-xml

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "xml";
  ipkg = "xml.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "madman-bob";
    repo = "idris2-xml";
    rev = "bfb02ff5c195218de7d33ed0ee9e6a26c60c0f0b";
    hash = "sha256-9L0Cb+xr712ejB8iIHAy5pbpDE5eWhhOszXhBcdOEp0=";  # hash-updated: 2026-06-19 16:30:16;  # hash-updated: 2026-05-02 03:10:17
  };
  deps = [ ];
}
