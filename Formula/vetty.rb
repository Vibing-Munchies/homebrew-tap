class Vetty < Formula
  # Fetched with git over SSH: the repository is private, a tarball URL would need a token.
  url "ssh://git@github.com/Vibing-Munchies/vetty.git",
      using:    :git,
      tag:      "v0.1.0",
      revision: "75148d1f7c1a4f6dcdb785805f31bf4e1679f2fd"

  depends_on "go" => :build

  def install
    # std_go_args already passes -trimpath and -ldflags "-s -w".
    system "go", "build", *std_go_args
  end

  def caveats
    <<~EOS
      vetty needs Docker Desktop. Build the lab images once, and again after every upgrade:
        vetty lab build
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/vetty version").strip
  end
end
