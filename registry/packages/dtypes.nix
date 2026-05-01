# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/JankaGramofonomanka/idris-dtypes

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "dtypes";
  ipkg = "dtypes.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "JankaGramofonomanka";
    repo = "idris-dtypes";
    rev = "master";
    hash = "sha256-hSJw9oi44BAD+vJxWRb8bOElOZEga3XdfstFP35Hsos=";  # hash-updated: 2026-05-02 03:08:09
  };
  deps = [ ];
}
