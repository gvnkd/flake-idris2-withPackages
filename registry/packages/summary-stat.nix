# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-summary-stat

{ pkgs, buildIdrisWithDocs }:

# NOTE: Weak traversal interface can be found in `weaker-traversals` lib
buildIdrisWithDocs {
  pname = "summary-stat";
  ipkg = "summary-stat.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-summary-stat";
    rev = "master";
    hash = "sha256-WbY7CAVyqQDIsnwS5KPJg9xhjBfYrc5l+/gOFXPle9w=";  # hash-updated: 2026-05-02 03:09:57
  };
  deps = [
    "bounded-doubles"
    "weaker-traversals"
  ];
}
