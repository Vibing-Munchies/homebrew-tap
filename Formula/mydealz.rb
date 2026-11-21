class Mydealz < Formula
  # Fetched with git over SSH: the repository is private, a tarball URL would need a token.
  url "ssh://git@github.com/Vibing-Munchies/mydealz-cli.git",
      using:    :git,
      tag:      "v0.3.1",
      revision: "52b1151309c38064836f43c633ebfccd4a52c8d9"

  depends_on "go" => :build

  def install
    # std_go_args already passes -trimpath and -ldflags "-s -w".
    system "go", "build", *std_go_args
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mydealz version").strip
  end
end
