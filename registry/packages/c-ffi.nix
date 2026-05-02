# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://codeberg.org/joelberkeley/c-ffi

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "c-ffi";
  ipkg = "c-ffi.ipkg";
  src = builtins.fetchGit {
    url = "https://codeberg.org/joelberkeley/c-ffi";
    ref = "master";
    rev = "6c54ca867a124b3fa291b2ac3acdf54cd0f30110";
    allRefs = true;
  };
  deps = [ ];
}
