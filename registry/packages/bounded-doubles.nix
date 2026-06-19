# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/buzden/idris2-bounded-doubles

{ pkgs, buildIdrisWithDocs }:

let
  src = pkgs.fetchFromGitHub {
    owner = "buzden";
    repo = "idris2-bounded-doubles";
    rev = "078934f6ba4bf69284c9cbc365840e645e71f22d";
    hash = "sha256-D8R48MVrUu88JMSfOIEdxOWQR1XgXeqTImYBsRd0zlg=";  # hash-updated: 2026-06-19 16:27:23;  # hash-updated: 2026-05-02 03:07:44
  };
in
{
  bounded-doubles = buildIdrisWithDocs {
    pname = "bounded-doubles";
    ipkg = "bounded-doubles.ipkg";
    inherit src;
  deps = [ ];
  };
  bounded-doubles-hedgehog-generators = buildIdrisWithDocs {
    pname = "bounded-doubles-hedgehog-generators";
    ipkg = "hedgehog-generators.ipkg";
    inherit src;
    deps = [ "bounded-doubles" "hedgehog" ];
  };
}
