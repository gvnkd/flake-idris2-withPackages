# Custom packages maintained alongside the auto-generated HEAD.toml registry.
# These are packages from gvnkd's GitHub repositories.

{ pkgs, buildIdrisWithDocs }:
let
  fmt-src = pkgs.fetchFromGitHub {
    owner = "gvnkd";
    repo = "idris2-fmt";
    rev = "v0.14.3";
    hash = "sha256-X8M2nfdSSmG/X0G4zg4MItU0LrT6HgVqK9FOIY4vZ2U=";
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
    rev = "v0.1.2";
    hash = "sha256-NDsqIsvuCkdjbCYeG/XmByXnT4DL4jK3Z0uNCrlIUrk=";
  };

  tui-src = pkgs.fetchFromGitHub {
    owner = "emdash";
    repo = "idris2-tui";
    rev = "master";
    hash = "sha256-0heskQVWNyOS7eUJIZHUjjrdPByTslQ1gknTDbAXP6k=";
  };

  amon-src = pkgs.fetchFromGitHub {
    owner = "gvnkd";
    repo = "idris2-amon";
    rev = "master";
    hash = "sha256-DKrKfxG976UMIHJ5JllRi8IHYg/cQXBA8gYu/2SErvQ=";
  };
in
{
  # Source code formatter for Idris 2
  fmt = buildIdrisWithDocs {
    pname = "idris2-fmt";
    ipkg = "idris2-fmt.ipkg";
    src = fmt-src;
    deps = [ "prettier" "idris2" "optparse-applicative" ];
    postPatch = ''
      # Version is auto-generated from git tags but fetchFromGitHub strips git metadata
      sed -i 's/versionString = ".*"/versionString = "0.14.3"/' src/IdrisFmt/Version.idr
    '';
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
    postPatch = ''
      # Upstream forgot to bump version string in source
      sed -i 's/taiga-cli version 0\.1\.0/taiga-cli version 0.1.2/' src/Main.idr
    '';
  };

  # Terminal UI library for Idris 2
  tui = buildIdrisWithDocs {
    pname = "tui";
    ipkg = "tui.ipkg";
    src = tui-src;
    deps = [ "ansi" "json" "elab-util" "quantifiers-extra" ];
  };

  # Async extension for idris2-tui
  tui-async = buildIdrisWithDocs {
    pname = "tui-async";
    ipkg = "tui-async/tui-async.ipkg";
    src = tui-src;
    deps = [ "tui" "posix" "async" "async-epoll" ];
  };

  # Process monitor TUI (depends on tui-async)
  amon = buildIdrisWithDocs {
    pname = "amon";
    ipkg = "amon.ipkg";
    src = amon-src;
    deps = [ "json" "elab-util" "ansi" "tui" "tui-async" "posix" "streams" "streams-posix" ];
  };
}
