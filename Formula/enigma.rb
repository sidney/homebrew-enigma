class Enigma < Formula
  desc "Puzzle game inspired by Oxyd and Rock'n'Roll"
  homepage "https://www.nongnu.org/enigma/"
  url "https://github.com/Enigma-Game/Enigma/releases/download/1.30-beta/Enigma-1.30-beta-macbuild-src.tar.gz"
  version "1.30"
  sha256 "fe0a8436b862159fbd7d17bad1684f8f1df33bdff1b801bb3f904f3dbaab509e"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    # This uses the git tag to get version numbers.
    # Stable releases should be tagged like 1.21.1 or 1.30
    # For now let it match on 1.30-beta so we can test with it
    # and remove the (?:\D.*)? at the end when 1.30 is released
    regex(/v?(\d+(?:\.\d+)+)(?:\D.*)?$/i)
  end

  bottle do
    root_url "https://github.com/Enigma-Game/homebrew-enigma/releases/download/enigma-1.30"
    rebuild 1
    sha256 catalina:     "589928526ebda97b1e98478abf05a7aec365cee59c97a628b5849a998f78a51a"
    sha256 x86_64_linux: "fa0396b158558b844fc102d0bbd561250f2ab019ff985eb886404fad00791b61"
  end

  head do
    url "https://github.com/Enigma-Game/Enigma.git", branch: "master"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "texi2html" => :build
  end

  depends_on "imagemagick" => :build
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

  on_linux do
    depends_on "gcc"
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--with-system-enet",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    system "strip", bin/"enigma"
    if build.head?
      system "make", "dist"
      mkdir_p prefix/"dist" if build.head?
      dist_tar = Dir["enigma-*.tar.gz"]
      odie "Unexpected number of artifacts!" if dist_tar.length != 1
      (prefix/"dist").install dist_tar
    end
    mkdir_p prefix/"etc"
    (prefix/"etc").install "etc/enigmabuilddmg"
    (prefix/"etc").install "etc/Info.plist"
    (prefix/"etc").install "etc/enigma.icns"
    (prefix/"etc").install "etc/menu_bg.jpg"
  end

  test do
    assert_equal "Enigma v#{version}", shell_output("#{bin}/enigma --version").chomp
  end
end
