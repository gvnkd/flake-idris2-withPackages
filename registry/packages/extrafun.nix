# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/jcranch/extrafun

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "extrafun";
  ipkg = "extrafun.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "jcranch";
    repo = "extrafun";
    rev = "86cca4e39180fce2497880fcefe6943ec2396670";
    hash = "sha256-6hEAhZZBeNzy/4djnCGEWEo/Xytc8QEmfpehCj8eL8A=";  # hash-updated: 2026-06-19 16:28:09;  # hash-updated: 2026-05-02 03:08:14
  };
  deps = [ ];
}
