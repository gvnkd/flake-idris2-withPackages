# Custom packages maintained alongside the auto-generated HEAD.toml registry.
# These are packages from gvnkd's GitHub repositories.

{ pkgs, buildIdrisWithDocs }:
let
  fmt-src = pkgs.fetchFromGitHub {
    owner = "gvnkd";
    repo = "idris2-fmt";
    rev = "v0.11.1";
    hash = "sha256-esPK/euCF94uquDsTicpXsl5E1812o8qdnjl4N760NY=";
  };

  optparse-src = pkgs.fetchFromGitHub {
    owner = "gvnkd";
    repo = "idris2-optparse-applicative";
    rev = "master";
    hash = "sha256-vTLvVgMFiLIwvDhKC5996S7fTjYJDnr73ZEBs+2Dax4=";
  };

  taiga-cli-src = pkgs.fetchFromGitHub {
    owner = "gvnkd";
    repo = "idris2-taiga-cli";
    rev = "master";
    hash = "sha256-PDiQQ4FvoaFTx7qowjYCx0kTN5aU6NIw9GUAtEViGF0=";
  };
in
{
  # Source code formatter for Idris 2
  fmt = buildIdrisWithDocs {
    pname = "idris2-fmt";
    ipkg = "idris2-fmt.ipkg";
    src = fmt-src;
    deps = [ "prettier" "idris2" "optparse-applicative" ];
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
    postPatch = ''
      # Upstream example uses old function name runParserWith (renamed to runParser)
      find example -name "*.idr" -exec sed -i 's/runParserWith/runParser/g' {} +
    '';
  };

  # Taiga CLI tool
  taiga-cli = buildIdrisWithDocs {
    pname = "taiga-cli";
    ipkg = "taiga-cli.ipkg";
    src = taiga-cli-src;
    deps = [ "json" "elab-util" "sop" "contrib" "tls" "optparse-applicative" ];
  };
}
