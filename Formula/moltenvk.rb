class Moltenvk < Formula
  desc "MoltenVK is an implementation of the Vulkan 1.0 graphics and compute API, that runs on Apple's Metal graphics "
  homepage "https://github.com/KhronosGroup/MoltenVK"
  url "https://github.com/KhronosGroup/MoltenVK/archive/v1.0.32.tar.gz"
  sha256 "43538642e604976883e86462a52f571e6aa7576fe5f4f0d3bee38227bca8c086"
  head "https://github.com/KhronosGroup/MoltenVK.git", :tag => "v1.0.32"
  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "python3" => :build
  depends_on "cereal"
  depends_on "spirv-tools"

  resource "Vulkan-Headers" do
    url "https://github.com/KhronosGroup/Vulkan-Headers.git", :commit => "c200cb25db0f47364d3318d92c1d8e9dfff2fef1"
  end

  resource "Vulkan-Portability" do
    url "https://github.com/KhronosGroup/Vulkan-Portability.git", :commit => "53be040f04ce55463d0e5b25fd132f45f003e903"
  end

  resource "SPIRV-Cross" do
    url "https://github.com/KhronosGroup/SPIRV-Cross.git", :commit => "a029d3faa12082bb4fac78351701d832716759df"
  end

  resource "glslang" do
    url "https://github.com/KhronosGroup/glslang.git", :commit => "2898223375d57fb3974f24e1e944bb624f67cb73"
  end

  resource "Vulkan-Tools" do
    url "https://github.com/KhronosGroup/Vulkan-Tools.git", :commit => "ff56a741b1cce8ae20ff6276f51100e668e9c4f5"
  end

  resource "VulkanSamples" do
    url "https://github.com/KhronosGroup/VulkanSamples.git", :commit => "5810b01149ef4f76fd92d7e085d980017379a93b"
  end

  def install
    #args = std_cmake_args + %w[
    #  -DSPIRV_BUILD_COMPRESSION=ON
    #]
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