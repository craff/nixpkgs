{ stdenv, fetchurl, libogg }:

stdenv.mkDerivation rec {
  name = "flac-1.2.1";

  src = fetchurl {
    url = mirror://sourceforge/flac/flac-1.2.1.tar.gz;
    sha256 = "1pry5lgzfg57pga1zbazzdd55fkgk3v5qy4axvrbny5lrr5s8dcn";
  };

  buildInputs = [ libogg ];

  patches =
    [ # Fix for building on GCC 4.3.
      (fetchurl {
        url = "http://sourceforge.net/p/flac/patches/_discuss/thread/9d4c7504/d8ea/attachment/flac-1.2.1-gcc-4.3-includes.patch";
        sha256 = "1m6ql5vyjb2jlp5qiqp6w0drq1m6x6y3i1dnl5ywywl3zd36k0mr";
      })
    ];

  meta = {
    homepage = http://flac.sourceforge.net;
    description = "Library and tools for encoding and decoding the FLAC lossless audio file format";
  };
}
