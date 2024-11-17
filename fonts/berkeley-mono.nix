{ lib, stdenv }:

stdenv.mkDerivation {
  pname = "berkeley-mono";
  version = "1.0";

  src = builtins.fetchGit {
    url = "git@github.com:raulescobar-g/berkeley-mono.git";
    ref = "main";
    rev = "f5f28cb97d7c2ec87bb7b9d2576dfab100adcbb2";
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r $src/berkeley-mono/TTF/* $out/share/fonts/
  '';

  meta = with lib; {
    description = "Berkeley Mono Font";
  };
}
