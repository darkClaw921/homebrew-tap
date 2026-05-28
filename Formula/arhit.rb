class Arhit < Formula
  desc "CLI for code architecture and documentation — for AI agents and humans"
  homepage "https://github.com/darkClaw921/arhit"
  url "https://github.com/darkClaw921/arhit/archive/refs/tags/v0.2.12.tar.gz"
  sha256 "0d0b7894d1fd33ec04b10149578a32eb11f22637bf3950a75ffd7b23c8dd65f1"
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
