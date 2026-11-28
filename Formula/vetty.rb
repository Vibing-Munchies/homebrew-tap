class Vetty < Formula
  # Fetched with git over SSH: the repository is private, a tarball URL would need a token.
  url "ssh://git@github.com/Vibing-Munchies/vetty.git",
      using:    :git,
      tag:      "v0.2.0",
      revision: "ab61da9f50c7e6d51d87677901afdb8130ea7146"

  depends_on "go" => :build

  def install
    # std_go_args already passes -trimpath and -ldflags "-s -w".
    system "go", "build", *std_go_args
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/vetty version").strip
  end
end
