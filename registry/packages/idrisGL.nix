# IdrisGL — SDL2 graphics library
# Source: https://github.com/ECburx/Idris2GL
# External deps: SDL2, SDL2_image, SDL2_ttf, SDL2_gfx, SDL2_mixer

{ pkgs, buildIdrisWithDocs }:

buildIdrisWithDocs {
  pname = "idrisGL";
  ipkg = "idrisGL.ipkg";
  src = pkgs.fetchFromGitHub {
    owner = "ECburx";
    repo = "Idris2GL";
    rev = "main";
    hash = "sha256-N5xrWhDBNJMb7jOjuz5qaqqYgGPYn21I0ERtuZpc3Wo=";
  };
  cDeps = [ pkgs.SDL2 pkgs.SDL2_image pkgs.SDL2_ttf pkgs.SDL2_gfx pkgs.SDL2_mixer ];
  nativeBuildInputs = [ pkgs.gnumake pkgs.pkg-config pkgs.dos2unix ];
  NIX_CFLAGS_COMPILE = [
    "-I${pkgs.SDL2.dev or pkgs.SDL2}/include/SDL2"
    "-I${pkgs.SDL2_gfx}/include/SDL2"
    "-I${pkgs.SDL2_image}/include/SDL2"
    "-I${pkgs.SDL2_ttf}/include/SDL2"
    "-I${pkgs.SDL2_mixer.dev or pkgs.SDL2_mixer}/include/SDL2"
  ];
  postPatch = ''
    ${pkgs.dos2unix}/bin/dos2unix src/c_src/Makefile
    substituteInPlace src/c_src/Makefile \
      --replace-fail 'SDL_FLAG          := -lSDL2' 'SDL_FLAG          := $(shell pkg-config --libs sdl2)' \
      --replace-fail 'SDL_IMG_FLAG      := $(SDL_FLAG) -lSDL2_image' 'SDL_IMG_FLAG      := $(shell pkg-config --libs sdl2 SDL2_image)' \
      --replace-fail 'SDL_GFX_FLAG      := $(SDL_FLAG) -lSDL2_gfx' 'SDL_GFX_FLAG      := $(shell pkg-config --libs sdl2 SDL2_gfx)' \
      --replace-fail 'SDL_TTF_FLAG      := $(SDL_FLAG) -lSDL2_ttf' 'SDL_TTF_FLAG      := $(shell pkg-config --libs sdl2 SDL2_ttf)' \
      --replace-fail 'SDL_MIXER_FLAG    := $(SDL_FLAG) -lSDL2_mixer' 'SDL_MIXER_FLAG    := $(shell pkg-config --libs sdl2 SDL2_mixer)'
  '';
}
