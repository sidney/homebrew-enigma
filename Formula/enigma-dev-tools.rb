class EnigmaDevTools < Formula
  desc "Developer tools for Enigma game project"
  homepage "https://www.nongnu.org/enigma/"
  url "https://github.com/Enigma-Game/Enigma/releases/download/1.30/Enigma-1.30-src.tar.gz"
  sha256 "ae64b91fbc2b10970071d0d78ed5b4ede9ee3868de2e6e9569546fc58437f8af"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(/v?(\d+(?:\.\d+)+)$/i)
  end

  bottle :unneeded

  depends_on "create-dmg"
  depends_on "dylibbundler"
  depends_on "enigma"
  depends_on "fileicon"
  depends_on "imagemagick"
  depends_on :macos
  depends_on "osxutils"

  def install
    bin.install "etc/enigmabuilddmg"
    mkdir_p "#{Formula["enigma"].opt_prefix}/etc"
    ("#{Formula["enigma"].opt_prefix}/etc").install "etc/Info.plist"
    ("#{Formula["enigma"].opt_prefix}/etc").install "etc/enigma.icns"
    ("#{Formula["enigma"].opt_prefix}/etc").install "etc/menu_bg.jpg"
  end

  test do
    assert_equal "#!/bin/bash", shell_output("head -1 #{bin}/enigmabuilddmg").chomp
  end
end
