class Arhit < Formula
  desc "CLI for code architecture and documentation — for AI agents and humans"
  homepage "https://github.com/darkClaw921/arhit"
  url "https://github.com/darkClaw921/arhit/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  depends_on "node@20"

  def install
    system "npm", "install", "--production=false"
    system "npm", "run", "bundle"

    libexec.install "bin/arhit-bundle.cjs"

    (bin/"arhit").write <<~EOS
      #!/bin/bash
      exec "#{Formula["node@20"].opt_bin}/node" "#{libexec}/arhit-bundle.cjs" "$@"
    EOS
  end

  test do
    system bin/"arhit", "--version"
  end
end
