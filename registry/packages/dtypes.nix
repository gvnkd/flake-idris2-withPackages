# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/JankaGramofonomanka/idris-dtypes

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "dtypes";
  ipkg = "dtypes.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "JankaGramofonomanka";
    repo = "idris-dtypes";
    rev = "028eb21c8f157037b2fa75e3f911cb33471e2774";
    hash = "sha256-hSJw9oi44BAD+vJxWRb8bOElOZEga3XdfstFP35Hsos=";  # hash-updated: 2026-06-19 16:28:00;  # hash-updated: 2026-05-02 03:08:09
  };
  deps = [ ];
}
