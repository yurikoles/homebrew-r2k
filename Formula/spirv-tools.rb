class SpirvTools < Formula
  desc "Provides an API and commands for processing SPIR-V modules"
  homepage "https://github.com/KhronosGroup/SPIRV-Tools"
  url "https://github.com/KhronosGroup/SPIRV-Tools/archive/v2019.1.tar.gz"
  sha256 "9f7dac47201c86cc2336252630f1471d52b9207a3b01c5411daefcfe827f410f"
  head "https://github.com/KhronosGroup/SPIRV-Tools.git", :tag => "v2019.1"
  depends_on "cmake" => :build

  resource "SPIRV-Headers" do
    url "https://github.com/KhronosGroup/SPIRV-Headers.git", :using => :git
  end

  def install
    args = std_cmake_args + %w[
      -DSPIRV_SKIP_EXECUTABLES=ON
      -DSPIRV_BUILD_COMPRESSION=ON
    ]
    resources.each do |resource|
      resource.stage buildpath/"external"/resource.name 
    end

    mkdir "build" do
      system "cmake", "..", *args
      system "make", "install"
      include.install_symlink ["../external/include/spirv/"]
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
