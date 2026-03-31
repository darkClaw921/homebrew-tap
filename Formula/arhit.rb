class Arhit < Formula
  desc "CLI for code architecture and documentation — for AI agents and humans"
  homepage "https://github.com/darkClaw921/arhit"
  url "https://github.com/darkClaw921/arhit/archive/refs/tags/v0.2.1.tar.gz"
  sha256 "bba4d3831a1be411ba488ef2e42685ae03e44818ff3133410bd58a7ebd9b26b0"
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
