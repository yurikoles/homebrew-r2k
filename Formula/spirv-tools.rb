class SpirvTools < Formula
  desc "Provides an API and commands for processing SPIR-V modules"
  homepage "https://github.com/KhronosGroup/SPIRV-Tools"
  url "https://github.com/KhronosGroup/SPIRV-Tools.git", :commit => "117a1fd11f11e9bef9faa563c3d5156cc6ab529c"
  head "https://github.com/KhronosGroup/SPIRV-Tools.git"
  depends_on "cmake" => :build
  depends_on "rafaga/r2k/spirv-headers"

  def install
    # Disabling Tests for now
    args = std_cmake_args + [
      "-DSPIRV_BUILD_COMPRESSION=ON",
      "-DSPIRV-Headers_SOURCE_DIR=#{HOMEBREW_PREFIX}",
      "-DSPIRV_SKIP_TESTS=ON"
    ]

    mkdir "build" do
      system "cmake", "..", *args
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
