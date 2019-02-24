class SpirvHeaders < Formula
  desc "Provides the header files for the Vulkan SPIR-V Registry"
  homepage "https://github.com/KhronosGroup/SPIRV-Headers"
  url "https://github.com/KhronosGroup/SPIRV-Headers.git", :commit => "79b6681aadcb53c27d1052e5f8a0e82a981dbf2f"
  version "1.1-rc2"
  head "https://github.com/KhronosGroup/SPIRV-Headers.git"
  depends_on "cmake" => :build

  def install
    args = std_cmake_args + [
      "-DSPIRV_HEADERS_SKIP_EXAMPLES=ON",
    ]
    mkdir "build" do
      system "cmake", *args, ".."
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
