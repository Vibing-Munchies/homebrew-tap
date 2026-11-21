class Kehrwoche < Formula
  # Fetched with git over SSH: the repository is private, a tarball URL would need a token.
  url "ssh://git@github.com/Vibing-Munchies/kehrwoche.git",
      using:    :git,
      tag:      "v0.5.0",
      revision: "ffc3aa425cac50e9f2b81d9a754d5de0bb66e9cd"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kehrwoche --version")
  end
end
