class VulkanPortability < Formula
  desc "Provides the spec description and header files for the Vulkan Portability extension"
  homepage "https://github.com/KhronosGroup/Vulkan-Portability"
  url "https://github.com/KhronosGroup/Vulkan-Portability/archive/v0.2.tar.gz"
  sha256 "2508a2dd0e111cb7d4636a54d454e7172ab33c48cba0e6e86e6fdb7cf48becb5"
  head "https://github.com/KhronosGroup/Vulkan-Portability.git", :tag => "v0.2"
  depends_on "cmake" => :build
  depends_on "vulkan-headers"

  def install
    include.install "#{HOMEBREW_PREFIX}/"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test libspirv`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end