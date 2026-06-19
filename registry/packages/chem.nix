# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-chem

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-chem";
    rev = "55b05f31392e73e3690ffd766aa9ec789b87e3c7";
    hash = "sha256-ERvJVt23/TmXKn0gAY71b7Lu0JD14iB8LE0FCY5bS4E=";  # hash-updated: 2026-06-19 16:27:26;  # hash-updated: 2026-05-02 03:07:47
  };
in
{
  chem = buildIdrisWithDocs {
    pname = "chem";
    ipkg = "chem.ipkg";
    inherit src;
  deps = [ "elab-util" "finite" "ilex" "indexed-graph" "pretty-show" "quantifiers-extra" "refined" ];
  };
  chem-generators = buildIdrisWithDocs {
    pname = "chem-generators";
    ipkg = "chem-generators/chem-generators.ipkg";
    inherit src;
    deps = [ "chem" "hedgehog" ];
  };
}
