class EnigmaDevTools < Formula
  desc "Developer tools for Enigma game project"
  homepage "https://www.nongnu.org/enigma/"
  url "file:///dev/null"
  version "1.30"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  license "GPL-2.0-or-later"

  bottle :unneeded

  depends_on "create-dmg"
  depends_on "dylibbundler"
  depends_on "enigma-game/enigma/enigma"
  depends_on "fileicon"
  depends_on "imagemagick"
  depends_on :macos
  depends_on "osxutils"

  def install
    # The file comes from the enigma install, but it is only used for development
    bin.mkpath
    mkdir_p "etc"
    cp "#{Formula["enigma"].opt_prefix}/etc/enigmabuilddmg", "etc/enigmabuilddmg"
    bin.install "etc/enigmabuilddmg"
  end

  test do
    assert_equal "#!/bin/bash", shell_output("head -1 #{bin}/enigmabuilddmg").chomp
  end
end
