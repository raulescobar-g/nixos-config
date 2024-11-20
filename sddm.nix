{ stdenv }:
{
  oxocarbon-sddm-theme = stdenv.mkDerivation rec {
    pname = "oxocarbon-sddm-theme";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/${pname}
    '';
    src = builtins.fetchDir ./sddm 
  };
}
