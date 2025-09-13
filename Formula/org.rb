class Org < Formula
  desc      "org: safe VM-backed dev helper"
  homepage  "https://github.com/tjamescouch/org"
  license   "MIT"
  version   "1.0.9"

  url "https://github.com/tjamescouch/org/releases/download/v1.0.9/orgctl-1.0.9.tar.gz"
  sha256 "a5f7c50bd2c3ba50da9a49ecaf5258cc5bec37a6cab068489f10c7f287c83ce9"

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
