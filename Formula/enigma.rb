class Enigma < Formula
  desc "Puzzle game inspired by Oxyd and Rock'n'Roll"
  homepage "https://www.nongnu.org/enigma/"
  url "https://github.com/Enigma-Game/Enigma/releases/download/1.30-beta/Enigma-macbuild-1.30-beta-src.tar.gz"
  sha256 "54ff439d3c2092d39074136b536d1e1b7489f5c9353a2d55cfa56ae7f1013114"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/enigma[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  bottle do
    sha256 cellar: :any, catalina:    "38e4eb761c8c03ec2ff3221d576335d60c60ecb5f369e69098d34740118d48e4"
    sha256 cellar: :any, mojave:      "8011aae1fa4e166dd9fb406844b1efcb246eb26ecc4e29c67dec71a3f8a7b231"
    sha256 cellar: :any, high_sierra: "9eeb7a516f7188b38bc1a9e9ea2450db22391e65401d1377028881c11acbcc15"
    sha256 cellar: :any, sierra:      "cdca7a198f3decfc3d387d590f84a7c3125adb06185469afa737eb5d61c150b3"
  end

  head do
    url "https://github.com/Enigma-Game/Enigma.git", branch: "macbuild"
    depends_on "texi2html" => :build
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "imagemagick" => :build
  depends_on "osxutils" => :build
  depends_on "pkg-config" => :build
  depends_on "enet"
  depends_on "freetype"
  depends_on "libpng"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer"
  depends_on "sdl2_ttf"
  depends_on "xerces-c"

  def install
    ENV.cxx11
    ENV.append "CXXFLAGS", "-std=c++14"
    ENV.append "LDFLAGS", "-liconv"
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--with-system-enet",
                          "--prefix=#{prefix}"
    system "make"
    system "make", "install"
    system "strip", bin/"enigma"
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
