# Custom packages maintained alongside the auto-generated HEAD.toml registry.
# These are packages from gvnkd's GitHub repositories.

{ pkgs, buildIdrisWithDocs }:
let
  fmt-src = pkgs.fetchFromGitHub {
    owner = "gvnkd";
    repo = "idris2-fmt";
    rev = "master";
    hash = "sha256-R9SaDu84iK9BscYIr/lgpWWUM/FzTYPQUAerFrpYtR0=";
  };

  optparse-src = pkgs.fetchFromGitHub {
    owner = "gvnkd";
    repo = "idris2-optparse-applicative";
    rev = "master";
    hash = "sha256-ydqjmE3tGfc61B2wMTnxatlHiffMptl3VVV5gJbUDCI=";
  };

  taiga-cli-src = pkgs.fetchFromGitHub {
    owner = "gvnkd";
    repo = "idris2-taiga-cli";
    rev = "master";
    hash = "sha256-x0hbv5bM/C3+w1Htm+2SNhuUN3WVCwAHMT9rYKw6ehU=";
  };
in
{
  # Source code formatter for Idris 2
  fmt = buildIdrisWithDocs {
    pname = "idris2-fmt";
    ipkg = "idris2-fmt.ipkg";
    src = fmt-src;
    deps = [ "prettier" "idris2" ];
  };

  # Applicative CLI option parser library
  optparse-applicative = buildIdrisWithDocs {
    pname = "optparse-applicative";
    ipkg = "optparse-applicative.ipkg";
    src = optparse-src;
    deps = [ ];
  };

  # Example executable for optparse-applicative
  optparse-applicative-example = buildIdrisWithDocs {
    pname = "optparse-applicative-example";
    ipkg = "example/optparse-applicative-example.ipkg";
    src = optparse-src;
    deps = [ "optparse-applicative" ];
  };

  # Taiga CLI tool
  taiga-cli = buildIdrisWithDocs {
    pname = "taiga-cli";
    ipkg = "taiga-cli.ipkg";
    src = taiga-cli-src;
    deps = [ "json" "elab-util" "sop" "contrib" "tls" ];
  };
}
