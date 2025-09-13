class Org < Formula
  desc      "org: safe VM-backed dev helper"
  homepage  "https://github.com/tjamescouch/org"
  license   "MIT"
  version   "1.0.6"

  url "https://github.com/tjamescouch/org/releases/download/v1.0.6/orgctl-1.0.6.tar.gz"
  sha256 "34d369e49792da05792d66a8c8ae9621f653ee0699dec99f685b3eacacf58c42"

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
