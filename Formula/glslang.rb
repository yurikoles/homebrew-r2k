class Glslang < Formula
  desc "An OpenGL and OpenGL ES shader front end and validator"
  homepage "https://github.com/KhronosGroup/glslang"
  url "https://github.com/KhronosGroup/glslang.git", :commit => "2898223375d57fb3974f24e1e944bb624f67cb73"
  head "https://github.com/KhronosGroup/glslang.git"
  version "7.11.3113"
  depends_on "cmake" => :build
  depends_on "ninja" => :build
  depends_on "spirv-headers" => :build
  depends_on "spirv-tools"
  depends_on "bison" => :optional

  def install
    # Disabling Tests for now
    args = std_cmake_args + [
      "-DBUILD_SHARED_LIBS=ON",
      "-DCMAKE_CXX_FLAGS=-I#{HOMEBREW_PREFIX}/include",
      "-DCMAKE_STATIC_LINKER_FLAGS=#{Formula["spirv-tools"].opt_lib}/libSPIRV-Tools.a",
      "-DCMAKE_EXE_LINKER_FLAGS=-L#{HOMEBREW_PREFIX}/lib",
      "-DENABLE_GLSLANG_BINARIES=OFF",
      "-DBUILD_SHARED_LIBS=OFF",
    ]

    inreplace Dir["#{buildpath}/CMakeLists.txt"].each do |s|
      s.gsub! "add_subdirectory(External)", "# add_subdirectory(External)"
      s.gsub! "if(ENABLE_OPT)", \
              "set(ENABLE_OPT ON)\n" \
              "if(ENABLE_OPT)"
    end

    inreplace Dir["#{buildpath}/SPIRV/CMakeLists.txt"].each do |s|
      s.gsub! "target_include_directories(SPIRV PUBLIC ../External)", "target_include_directories(SPIRV PUBLIC #{HOMEBREW_PREFIX}/include)"
    end

    #(buildpath/"external").install_symlink "#{Formula['spirv-tools'].opt_prefix}" => "spirv-tools"
    #Forcing the use of spirv-tools

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
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
