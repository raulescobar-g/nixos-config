{ stdenv, fetchFromGitHub }:
{
  oxocarbon-sddm-theme = stdenv.mkDerivation rec {
    pname = "oxocarbon-sddm-theme";
    version = "88b4b693df69c1bb9a1f28d3dd772d3f4fa76ba1";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/${pname}
    '';
    src = fetchFromGitHub {
      owner = "raulescobar-g";
      repo = "oxocarbon-sddm-theme";
      rev = "${version}";
      sha256 = "sha256-hSKeGUnw1yIQP0sRfweuFb+q7arBlU50tlpSyJfzJ4I=";
    };
  };
}
