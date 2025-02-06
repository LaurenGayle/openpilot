# simple.nix
with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    clang
    cppcheck
    gnumake pkgsCross.muslpi.buildPackages.gcc
    capnproto 
    ocamlPackages.capnp
    #python311Packages.pycapnp
    emacsPackages.capnp-mode
    curl 
    openssl
    git 
    git-lfs 
    ffmpeg 
    #libavformat-dev 
    ocamlPackages.ffmpeg-avcodec
    ocamlPackages.ffmpeg-avdevice
    ocamlPackages.ffmpeg-avutil
    ocamlPackages.ffmpeg-avfilter 
    python312Packages.bz2file 
    ocamlPackages.eigen 
    #libffi-dev 
    glew 
    mesa
    chickenPackages_5.chickenEggs.glfw3 #libglfw3-dev 
    libglibutil
    libsForQt5.qt5ct #libqt5charts5-dev 
    ncurses5
    libhv #libssl-dev 
    libusbp
    czmq #libzmq3-dev 
    sqlite #libsqlite3-dev
    systemdLibs
    glibcLocales 
    opencl-headers
    ocl-icd #ocl-icd-libopencl1 
    #ocl-icd-opencl-dev 
    portaudio# portaudio19-dev 
    libsForQt5.qt5.qtmultimedia 
    libsForQt5.qt5.qtdeclarative 
    libsForQt5.qt5.qttools 
    libsForQt5.qt5.qtsvg
    libsForQt5.qt5.qtserialbus  
    libsForQt5.qt5.qtx11extras 
    savvycan
    xorg_sys_opengl #libqt5opengl5-dev
    casync 
    cmake 
    gnumake #make 
    clinfo 
    vtkWithQt5 #libqt5sql5-sqlite 
    readline
    libdwarf-lite 
    autoconf 
    libtool 
    bzip2
    #libarchive-dev 
    #libncursesw5-dev 
    #libportaudio2 
    #locales
    libgcc
    libsForQt5.qt5.qtbase
    #qtchooser 
    libsForQt5.qmake
    #qtbase5-dev-tools 
    python3Full #python3-dev 
    #python312Packages.venvShellHook #python3-venv
    #libavresample-dev
    #qt5-default 
    #python-dev
    python312Packages.pydevtool
    scons
    poetry
    libsForQt5.full
    kdePackages.full
    docker
  ];
}
