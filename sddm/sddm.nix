{ stdenv }:
{
  oxocarbon-sddm-theme = stdenv.mkDerivation rec {
    name = "oxocarbon-sddm-theme";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/${name}
    '';
    src = ./.;
  };
}
