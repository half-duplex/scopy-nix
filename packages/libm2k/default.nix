{
  lib,
  fetchFromGitHub,
  stdenv,
  cmake,
  libiio,
  python3,
  swig,
  buildExamples ? false,
  enableCSharpBindings ? false,
  enablePythonBindings ? false,
  enableTools ? false,
}: let
  inherit (lib) cmakeBool;
  version = "0.9.0";
in
  stdenv.mkDerivation {
    pname = "libm2k";
    inherit version;

    src = fetchFromGitHub {
      owner = "analogdevicesinc";
      repo = "libm2k";
      rev = "v${version}";
      hash = "sha256-3R0/tah7d3mfZc0NhAWHF4t1lejD2vMWj3kjMcWq2xk=";
      # main, as of 2026-05-18
      #rev = "34286ad79b2050b3e62e6edd335fc3fb83dca41f";
      #hash = "sha256-zno84tcRXBSOoLYQs3DLWOObAcOHnRKisaJI6btpRQc=";
    };

    buildInputs =
      [libiio]
      ++ (lib.optional (enableCSharpBindings || enablePythonBindings) swig);
    nativeBuildInputs =
      [cmake]
      ++ lib.optional enablePythonBindings python3;
    cmakeFlags = [
      "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
      (cmakeBool "BUILD_EXAMPLES" buildExamples)
      (cmakeBool "ENABLE_PYTHON" enablePythonBindings)
      (cmakeBool "ENABLE_CSHARP" enableCSharpBindings)
      (cmakeBool "ENABLE_TOOLS" enableTools)
      # don't try to install directly to /etc
      "-DUDEV_RULES_PATH=\${out}/\${UDEV_RULES_PATH}"
      # fix "Broken paths found in a .pc file!"
      "-DINSTALL_PKGCONFIG_DIR=\${CMAKE_INSTALL_FULL_LIBDIR}/pkgconfig"
    ];
    patches = [./version-hpp-path.patch];

    meta = {
      description = "A C++ library (bindings for Python and C#) for interfacing with the ADALM2000";
      homepage = "http://analogdevicesinc.github.io/libm2k";
      license = lib.licenses.lgpl21Only;
      platforms = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    };
  }
