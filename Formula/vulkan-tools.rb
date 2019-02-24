class VulkanTools < Formula
  desc "Tools and utilities to verify use of Vulkan API on Applications"
  homepage "https://github.com/KhronosGroup/Vulkan-Tools"
  url "https://github.com/KhronosGroup/Vulkan-Tools.git", :commit => "ff56a741b1cce8ae20ff6276f51100e668e9c4f5"
  version "1.1.97"
  head "https://github.com/KhronosGroup/Vulkan-Tools.git"
  depends_on "cmake" => :build
  depends_on "python" => :build

  resource "MoltenVK" do
    url "https://github.com/KhronosGroup/MoltenVK.git", :tag => "v1.0.32"
  end

  def install
    resources.each do |resource|
      resource.stage buildpath/"external"/resource.name
    end
    args = std_cmake_args + [
      "-DBUILD_CUBE=OFF",
      "-DBUILD_VULKANINFO=ON",
      "-DMOLTENVK_REPO_ROOT=#{prefix}/external/",
    ]
    mkdir "build" do
      system "cmake", "..", *args
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
