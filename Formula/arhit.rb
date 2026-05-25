class Arhit < Formula
  desc "CLI for code architecture and documentation — for AI agents and humans"
  homepage "https://github.com/darkClaw921/arhit"
  url "https://github.com/darkClaw921/arhit/archive/refs/tags/v0.2.10.tar.gz"
  sha256 "3b5c6ee83692c399eafab94be0f8fd2d2219a692f66a5b14f418e140c3a7dbef"
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
