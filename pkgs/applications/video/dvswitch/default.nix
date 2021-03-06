{ stdenv, fetchurl, alsaLib, boost, cmake, gtkmm, libXau, libXdmcp
, libXv, libav, pixman, libpthreadstubs, pkgconfig 
}:

stdenv.mkDerivation rec {
  name = "dvswitch-${version}";
  version = "0.8.3.6";

  src = fetchurl {
    url = "https://alioth.debian.org/frs/download.php/3615/${name}.tar.gz";
    sha256 = "7bd196389f9913ae08e12a29e168d79324c508bb545eab114df77b0375cd87f0";
  };

  buildInputs = [
    alsaLib boost cmake gtkmm libXau libXdmcp libXv libav
    libpthreadstubs pixman pkgconfig
  ];

  patchPhase = ''
    sed -e "s@prefix /usr/local@prefix $out@" -i CMakeLists.txt
  '';

  meta =  with stdenv.lib; {
    description = "interactive live video mixer for DV streams";
    homepage = "http://dvswitch.alioth.debian.org";
    license = licenses.gpl2Plus;
    maintainers = [ maintainers.goibhniu ];
  };
}
