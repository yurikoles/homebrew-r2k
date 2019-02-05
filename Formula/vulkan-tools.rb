class VulkanTools < Formula
  desc "Provides Vulkan tools and utilities that verify the correct use of the Vulkan API on Applications"
  homepage "https://github.com/KhronosGroup/Vulkan-Tools"
  url "https://github.com/KhronosGroup/Vulkan-Tools.git", :commit => "ff56a741b1cce8ae20ff6276f51100e668e9c4f5"
  head "https://github.com/KhronosGroup/Vulkan-Tools.git"
  depends_on "cmake" => :build
  depends_on "python" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args 
      system "make"
      system "make", "install"
    end
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
