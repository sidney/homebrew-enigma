class EnigmaDevTools < Formula
  desc "Developer tools for Enigma game project"
  homepage "https://www.nongnu.org/enigma/"
  url "https://raw.githubusercontent.com/Enigma-Game/Enigma/9cf51b87418ee16ba8a5f6bf0d95879501674add/etc/enigmabuilddmg"
  sha256 "58fa40f271df9b18350e03352e2d2925e7615939202ef21040f3f54e7deeaa9c"
  license "GPL-2.0-or-later"
  version "1.30-alpha"

  bottle :unneeded
  
  depends_on "dylibbundler"
  depends_on "imagemagick"
  depends_on "osxutils"
  depends_on "fileicon"
  depends_on "create-dmg"

  def install
    bin.install "enigmabuilddmg"
  end

  test do
    assert_equal "#!/bin/bash", shell_output("head -1 #{bin}/enigmabuilddmg").chomp
  end
end
