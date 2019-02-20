class SpirvCross < Formula
  desc "Provides a tool for parsing and converting SPIR-V to other shader language"
  homepage "https://github.com/KhronosGroup/SPIRV-Cross"
  url "https://github.com/KhronosGroup/SPIRV-Cross.git", :commit => "a029d3faa12082bb4fac78351701d832716759df"
  head "https://github.com/KhronosGroup/SPIRV-Cross.git"
  depends_on "cmake" => :build
  depends_on "rafaga/r2k/spirv-headers" => :build

  # resource "SPIRV-Headers" do
  #   url "https://github.com/KhronosGroup/SPIRV-Headers.git", :using => :git, :commit => "8bea0a266ac9b718aa0818d9e3a47c0b77c2cb23"
  # end

  def install
    # Disabling Tests for now
    # args = std_cmake_args + %w[
    #   -DSPIRV_BUILD_COMPRESSION=ON
    #   -DSPIRV-Headers_SOURCE_DIR="#{HOMEBREW_PREFIX}"
    #   -DSPIRV_SKIP_TESTS=ON
    # ]
    # resources.each do |resource|
    #   resource.stage buildpath/"external"/resource.name
    # end

    mkdir "build" do
      system "cmake", "..", *std_cmake_args
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
