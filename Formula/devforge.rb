# Homebrew formula for devforge (F.O.R.G.E.)
#
# Builds the `devforge` binary from source via cargo. Static assets are
# embedded into the binary via rust-embed (см. tmux-web/src/static_embed.rs),
# поэтому дополнительной установки ресурсов не требуется.
#
# Релиз делается скриптом ./release.sh <version> — он автоматически:
#   1) бампает версию в tmux-web/Cargo.toml,
#   2) ставит правильный url в Formula/devforge.rb,
#   3) считает sha256 у tarball'а с GitHub,
#   4) пушит обновлённую формулу в общий tap darkClaw921/homebrew-tap.
#
# Локальная проверка без публикации:
#   brew install --build-from-source --HEAD ./Formula/devforge.rb
class Devforge < Formula
  desc "Tmux + kanban + git web cockpit (F.O.R.G.E.)"
  homepage "https://github.com/darkClaw921/F.O.R.G.E."
  url "https://github.com/darkClaw921/F.O.R.G.E./archive/refs/tags/v0.1.18.tar.gz"
  sha256 "e83581c0a31d5572492f634185f6f67565dd5697ff35d07e2534c1f5aa8caee3"
  license "MIT"
  head "https://github.com/darkClaw921/F.O.R.G.E..git", branch: "master"

  depends_on "rust" => :build
  depends_on "tmux"

  def install
    cd "tmux-web" do
      system "cargo", "install", *std_cargo_args
    end
  end

  test do
    assert_match "devforge", shell_output("#{bin}/devforge --help 2>&1")
  end
end
