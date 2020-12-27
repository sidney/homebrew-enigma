class Enigma < Formula
  desc "Puzzle game inspired by Oxyd and Rock'n'Roll"
  homepage "https://www.nongnu.org/enigma/"
  url "https://github.com/Enigma-Game/Enigma/releases/download/1.30-alpha/enigma-1.30-alpha.tar.gz"
  sha256 "89a413beda58d96f6d19a7d45eb61bc395a8f091233cc3200dd9fd37881cd3ff"
  license "GPL-2.0-or-later"
  revision 1
  
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
                          "--prefix=#{prefix}"
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
