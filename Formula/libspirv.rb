# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class Libspirv < Formula
	desc "The SPIR-V Tools project provides an API and commands for processing SPIR-V modules."
	homepage "https://github.com/KhronosGroup/SPIRV-Tools"
	url "https://github.com/KhronosGroup/SPIRV-Tools/archive/v2019.1.tar.gz"
	sha256 "9f7dac47201c86cc2336252630f1471d52b9207a3b01c5411daefcfe827f410f"
	head "https://github.com/KhronosGroup/SPIRV-Tools.git", :using => :git
	# depends_on "cmake" => :build

	resource "libspirv-headers" do
		head "https://github.com/KhronosGroup/SPIRV-Headers.git", :using => :git
	end

	 # Store and restore some of our environment
	def save_env
		saved_cflags = ENV["CFLAGS"]
		saved_ldflags = ENV["LDFLAGS"]
		saved_homebrew_archflags = ENV["HOMEBREW_ARCHFLAGS"]
		saved_homebrew_cccfg = ENV["HOMEBREW_CCCFG"]
		saved_makeflags = ENV["MAKEFLAGS"]
		saved_homebrew_optflags = ENV["HOMEBREW_OPTFLAGS"]
		begin
			yield
		ensure
			ENV["CFLAGS"] = saved_cflags
			ENV["LDFLAGS"] = saved_ldflags
			ENV["HOMEBREW_ARCHFLAGS"] = saved_homebrew_archflags
			ENV["HOMEBREW_CCCFG"] = saved_homebrew_cccfg
			ENV["MAKEFLAGS"] = saved_makeflags
			ENV["HOMEBREW_OPTFLAGS"] = saved_homebrew_optflags
		end
	end


	def install
		resource("libspirv-headers").stage do
			save_env do
				dirs = []
				archs.each do |arch|
					dir = "external"
					dirs << dir

					cp Dir["*"], "#{dir}/external"
				end
			end
		end
		# ENV.deparallelize  # if your formula fails when building in parallel
		# Remove unrecognized options if warned by configure
		system "./configure", "--disable-debug",
			"--disable-dependency-tracking",
			"--disable-silent-rules",
			"--prefix=#{prefix}"
		# system "cmake", ".", *std_cmake_args
		system "make", "install" # if this fails, try separate make/make install steps
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
