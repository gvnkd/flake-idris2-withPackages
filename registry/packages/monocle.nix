# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/stefan-hoeck/idris2-monocle

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "monocle";
  ipkg = "monocle.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "stefan-hoeck";
    repo = "idris2-monocle";
    rev = "main";
    hash = "sha256-cxDCyaROw4xhvmC3kgZl4RQdFaA8+RcwUwVCMAsFRf8=";  # hash-updated: 2026-05-02 03:09:19
  };
  deps = [
    "elab-util"
    "quantifiers-extra"
  ];
}
