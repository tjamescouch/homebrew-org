class Org < Formula
  desc      "org: safe VM-backed dev helper"
  homepage  "https://github.com/tjamescouch/org"
  license   "MIT"
  version   "1.1.0"

  url "https://github.com/tjamescouch/org/releases/download/v1.1.0/orgctl-1.1.0.tar.gz"
  sha256 "dc6ee4ae609dc476d610e65f399c6670c694a4539d630216e3612dc90100b61c"

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
