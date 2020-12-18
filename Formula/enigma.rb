class Enigma < Formula
  desc "Puzzle game inspired by Oxyd and Rock'n'Roll"
  homepage "https://www.nongnu.org/enigma/"
  #url "https://github.com/sidney/Enigma/releases/download/test1.30-prealpha/enigma-test1.30-prealpha.tar.gz"
  #sha256 "330ba77de4135e74d34f47dda3822a4dc9535d1cddc53797b524c18127193dfb"
  license "GPL-2.0-or-later"
  revision 4

  livecheck do
    url :stable
  end

  head do
    url "https://github.com/Enigma-Game/Enigma.git"
    depends_on "texi2html" => :build
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "dylibbundler" => :build
  depends_on "imagemagick" => :build
  depends_on "osxutils" => :build
  depends_on "pkg-config" => :build
  depends_on "enet"
  depends_on "freetype"
  depends_on "gettext"
  depends_on "libpng"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer"
  depends_on "sdl2_ttf"
  depends_on "xerces-c"

  def install
    ENV.cxx11
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-libintl-prefix=#{Formula["gettext"].opt_prefix}",
                          "--with-system-enet"
    system "make", "gmo" if build.head?
    system "make"
    system "make", "macapp"
    system "make", "macpreview" if build.head?
    prefix.install "etc/macfiles" => "Enigma"
    bin.write_exec_script "#{prefix}/Enigma/Enigma.app/Contents/MacOS/enigma"
  end

  test do
    assert_equal "Enigma v#{version}", shell_output("#{bin}/enigma --version").chomp
  end
end
