# Auto-generated from idris2-pack-db HEAD.toml
# Source: https://gitlab.com/glaive-research/pipelines.git

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "pipelines";
  ipkg = "pipelines.ipkg";
  src = pkgs.fetchFromGitLab {
    owner = "glaive-research";
    repo = "pipelines";
    rev = "main";
    hash = "sha256-DXY3HrcBXLQjLoC5Q+uWZB9LkvXggT7cqw5Rd3z5iqA=";  # hash-updated: 2026-05-02 03:11:13
  };
  deps = [ ];
}
