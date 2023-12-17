{ lib }:

stdenv.mkDerivation {
  pname = "berkeley-mono";
  version = "1.0";

  src = builtin.fetchGit {
    owner = "raulescobar-g";
    repo = "Berkley-mono";
    rev = "f5f28cb97d7c2ec87bb7b9d2576dfab100adcbb2";
    sha256 = lib.fakeHash;    
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r $src/berkeley-mono/TTF/* $out/share/fonts/
  '';

  meta = with lib; {
    description = "Berkeley Mono Font";
    license = licenses.unfree;
  };
}
