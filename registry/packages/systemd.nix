# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Matthew-Mosior/idris2-systemd

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "systemd";
  ipkg = "systemd.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Matthew-Mosior";
    repo = "idris2-systemd";
    rev = "main";
    hash = "sha256-j8vTVL2Kh4wYCnSvub6eaQhigjZ4j32f0x7swHpASSM=";  # hash-updated: 2026-05-02 03:09:59
  };
  deps = [ "elin" "posix" ];
}
