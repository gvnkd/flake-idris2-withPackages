# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://github.com/Matthew-Mosior/idris2-systemd

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "systemd";
  ipkg = "systemd.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "Matthew-Mosior";
    repo = "idris2-systemd";
    rev = "e93a68eff6b5b027d093b44481c245f9cad767d3";
    hash = "sha256-j8vTVL2Kh4wYCnSvub6eaQhigjZ4j32f0x7swHpASSM=";  # hash-updated: 2026-06-19 16:29:54;  # hash-updated: 2026-05-02 03:09:59
  };
  deps = [ "elin" "posix" ];
}
