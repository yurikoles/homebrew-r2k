class SpirvHeaders < Formula
  desc "Provides the header files for the Vulkan SPIR-V Registry"
  homepage "https://github.com/KhronosGroup/SPIRV-Headers"
  url "https://github.com/KhronosGroup/SPIRV-Headers.git", :commit => "8bea0a266ac9b718aa0818d9e3a47c0b77c2cb23"
  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", *std_cmake_args, ".."
      system "cmake", "--build", ".", "--target", "install"
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
