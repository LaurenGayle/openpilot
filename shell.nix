{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  name = "cpp_project";
  buildInputs = with pkgs; [
    cmake
    ninja
    swig
    pcre
    bison
    flex
    openssl

    cereal
    cppcheck
    clang
    capnproto
    libsForQt5.full
    gcc-arm-embedded
    libgcc
    libarchive
    zeromq
    zmqpp
    czmq
    llvmPackages_latest.llvm

    ffmpeg
    glew
    mesa
    chickenPackages_5.chickenEggs.glfw3
    libglibutil
    ncurses5
    libhv
    libusbp
    sqlite
    systemdLibs
    glibcLocales
    opencl-headers
    portaudio
    bzip2
  ];

  nativeBuildInputs = [ pkgs.pkg-config ];

  shellHook = ''
    export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:$HOME/project/libmanolo/";
    export CMAKE_INCLUDE_PATH="$usr/local/include/":$CMAKE_INCLUDE_PATH;
    export CPLUS_INCLUDE_PATH="$usr/local/include/":$CPLUS_INCLUDE_PATH;
    export  NIX_LDFLAGS="-L${stdenv.cc.cc}/lib/gcc/${targetPlatform.config}/${stdenv.cc.cc.version}";
    export  CFLAGS="-B${stdenv.cc.cc}/lib/gcc/${targetPlatform.config}/${stdenv.cc.cc.version} -B ${stdenv.cc.libc}/lib";
    echo "Starting new shell";
  '';
}