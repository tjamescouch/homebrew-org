class Org < Formula
  desc      "org: safe VM-backed dev helper"
  homepage  "https://github.com/tjamescouch/org"
  license   "MIT"
  version   "0.9.0"

  url "https://github.com/tjamescouch/org/releases/download/v0.9.0/orgctl-0.9.0.tar.gz"
  sha256 "96bf6a2c120e6f4c4e075541933a4c5fd14c9dc57d7510213e213801a3123098"

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
