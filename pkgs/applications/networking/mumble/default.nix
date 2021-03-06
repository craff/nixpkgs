{ stdenv, fetchurl, qt4, libvorbis, boost, speechd, protobuf, libsndfile,
 avahi, dbus, libcap, pkgconfig,
jackSupport ? false, 
jackaudio ? null }:


stdenv.mkDerivation rec {
  name = "mumble-" + version;
  version = "1.2.3";

  src = fetchurl {
    url = "mirror://sourceforge/mumble/${name}.tar.gz";
    sha256 = "0p4as6bcmbzkiff1gvc0f277dzbz2sfys97gcbxw7gjamqi53285";
  };

  patchPhase = ''
    sed -e s/qt_ja_JP.qm// -i src/mumble/mumble.pro src/mumble11x/mumble11x.pro
    sed -e /qt_ja_JP.qm/d -i src/mumble/mumble_qt.qrc src/mumble11x/mumble_qt.qrc
    patch -p1 < ${ ./mumble-jack-support.patch }
  '';

  configurePhase = ''
    qmake CONFIG+=no-g15 CONFIG+=no-update \
      CONFIG+=no-embed-qt-translations CONFIG+=no-ice \
  '' 
  + stdenv.lib.optionalString jackSupport ''
    CONFIG+=no-oss CONFIG+=no-alsa CONFIG+=jackaudio
  '';


  buildInputs = [ qt4 libvorbis boost speechd protobuf libsndfile avahi dbus
    libcap pkgconfig ]
    ++ (stdenv.lib.optional jackSupport jackaudio);

  installPhase = ''
    mkdir -p $out
    cp -r ./release $out/bin
  '';

  meta = { 
    homepage = http://mumble.sourceforge.net/;
    description = "Low-latency, high quality voice chat software";
    license = "BSD";
    platforms = with stdenv.lib.platforms; linux;
    maintainers = with stdenv.lib.maintainers; [viric];
  };
}
