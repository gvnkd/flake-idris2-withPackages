# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://codeberg.org/joelberkeley/spidr

{ pkgs, buildIdrisWithDocs }:

let
  src = builtins.fetchGit {
    url = "https://codeberg.org/joelberkeley/spidr";
    ref = "master";
    allRefs = true;
  };
in
{
  pjrt-plugin-xla-cpu = buildIdrisWithDocs {
    pname = "pjrt-plugin-xla-cpu";
    ipkg = "pjrt-plugins/xla-cpu/pjrt-plugin-xla-cpu.ipkg";
    inherit src;
    deps = [ ];  # TODO: Add Idris dependencies
  };
  pjrt-plugin-xla-cuda = buildIdrisWithDocs {
    pname = "pjrt-plugin-xla-cuda";
    ipkg = "pjrt-plugins/xla-cuda/pjrt-plugin-xla-cuda.ipkg";
    inherit src;
    deps = [ ];  # TODO: Add Idris dependencies
  };
  spidr = buildIdrisWithDocs {
    pname = "spidr";
    ipkg = "spidr/spidr.ipkg";
    inherit src;
    deps = [ ];  # TODO: Add Idris dependencies
  };
  meta.broken = true;
}
