class MynewtNewtAT17 < Formula
  desc "Package, build and installation system for Mynewt OS applications"
  homepage "https://mynewt.apache.org"
  url "https://github.com/apache/mynewt-newt/archive/mynewt_1_7_0_tag.tar.gz"
  version "1.7.0"
  sha256 "6aefb5aaae06c4b9d514333ec682f62bd52e97e9d8e7b9f9c50e15983590f1f7"

  keg_only :versioned_formula

  bottle do
    root_url "https://github.com/JuulLabs-OSS/binary-releases/raw/master/mynewt-newt-tools_1.7.0"
    cellar :any_skip_relocation
    sha256 "fb1bb0f021ee5facfdbd4b0e4eb40d4c06a4bfffb10615052f279c20bf9a07ee" => :high_sierra
  end

  depends_on "go" => :build
  depends_on :arch => :x86_64

  def install
    contents = Dir["{*,.git,.gitignore}"]
    gopath = buildpath/"gopath"
    (gopath/"src/mynewt.apache.org/newt").install contents

    cd gopath/"src/mynewt.apache.org/newt/newt" do
      system "go", "build"
      bin.install "newt"
    end
  end

  test do
    # Compare newt version string
    assert_equal "1.7.0", shell_output("#{bin}/newt version").split.last
  end
end