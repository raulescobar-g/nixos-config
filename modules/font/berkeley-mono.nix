{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "berkeley-mono";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "raulescobar-g";
    repo = "Berkely-mono";
    rev = "f5f28cb";  # Replace with the specific commit hash
    sha256 = "4ceedab80bd72d267e4dab92dd00283bb4b7ff94"; # Replace with the appropriate hash
  };

  installPhase = ''
    mkdir -p $out/share/fonts
    cp -r $src/fonts/berkeley-mono/TTF/* $out/share/fonts/
  '';

  meta = with lib; {
    description = "Berkely Mono Font";
    homepage = "https://github.com/raulescobar-g/Berkely-mono";
    license = licenses.unfree; # Or the appropriate license
  };
}
