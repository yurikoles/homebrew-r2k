class Moltenvk < Formula
  desc "Implementation of the Vulkan 1.0 API, that runs on Apple's Metal API"
  homepage "https://github.com/KhronosGroup/MoltenVK"
  url "https://github.com/KhronosGroup/MoltenVK/archive/v1.0.32.tar.gz"
  sha256 "43538642e604976883e86462a52f571e6aa7576fe5f4f0d3bee38227bca8c086"
  head "https://github.com/KhronosGroup/MoltenVK.git", :tag => "v1.0.32"
  depends_on "cereal" => :build
  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "python" => :build
  depends_on "vulkan-headers" => :build
  depends_on "vulkan-portability" => :build
  depends_on "glslang"
  depends_on "spirv-cross"
  depends_on "spirv-tools"

  resource "Vulkan-Tools" do
    url "https://github.com/KhronosGroup/Vulkan-Tools.git", :commit => "ff56a741b1cce8ae20ff6276f51100e668e9c4f5"
  end

  resource "VulkanSamples" do
    url "https://github.com/LunarG/VulkanSamples.git", :commit => "5810b01149ef4f76fd92d7e085d980017379a93b"
  end

  def install
    # args = std_cmake_args + %w[
    #  -DSPIRV_BUILD_COMPRESSION=ON
    # ]
    resources.each do |resource|
      resource.stage buildpath/"external"/resource.name
    end
    system "make", "macos"
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
