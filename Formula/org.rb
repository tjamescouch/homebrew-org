class Org < Formula
  desc      "org: safe VM-backed dev helper"
  homepage  "https://github.com/tjamescouch/org"
  license   "MIT"
  version   "1.0.7"

  url "https://github.com/tjamescouch/org/releases/download/v1.0.7/orgctl-1.0.7.tar.gz"
  sha256 "6998e5d41643d7a9bddbb0a374a2e18114c75a08c2d0c88d2150c3110910dfb6"

  depends_on "bash"
  depends_on "coreutils"
  depends_on "curl"

  def install
    libexec.install "orgctl"
    (bin/"orgctl").write_env_script libexec/"orgctl", {
      PATH: "#{Formula["bash"].opt_bin}:#{Formula["coreutils"].opt_bin}:#{HOMEBREW_PREFIX}/bin:#{ENV["PATH"]}",
    }
  end

  test do
    system "#{bin}/orgctl", "version"
  end
end
