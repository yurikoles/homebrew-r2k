class VulkanPortability < Formula
  desc "Header files and spec for the Vulkan Portability extension"
  homepage "https://github.com/KhronosGroup/Vulkan-Portability"
  url "https://github.com/KhronosGroup/Vulkan-Portability.git", :commit => "53be040f04ce55463d0e5b25fd132f45f003e903"
  version "moltenvk-1.0.32"
  head "https://github.com/KhronosGroup/Vulkan-Portability.git"

  depends_on "cmake" => :build
  depends_on "rafaga/r2k/vulkan-headers"

  def install
    (include/"vulkan").install "include/vulkan/vk_extx_portability_subset.h"
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
