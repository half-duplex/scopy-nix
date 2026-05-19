{
  lib,
  fetchFromGitHub,
  stdenv,
  cmake,
  boost,
  gmp,
  libm2k,
  spdlog,
  volk,
  gnuradio,
  python3,
}: let
  version = "1.0.0.dev0";
in
  stdenv.mkDerivation {
    pname = "gr-m2k";
    inherit version;

    src = fetchFromGitHub {
      owner = "analogdevicesinc";
      repo = "gr-m2k";
      # main, as of 2026-05-18
      rev = "14808b8a196dc067748e6cd0a62d6d912a09de7b";
      hash = "sha256-LY3nKWPTJoFroey1Y98OFRIK8n/oAyP+a7beR34KcVI=";
    };

    buildInputs = [
      boost
      gmp
      gnuradio
      libm2k
      python3.pkgs.numpy
      python3.pkgs.pybind11
      spdlog
      volk
    ];
    nativeBuildInputs = [
      cmake
    ];

    meta = {
      description = "A GNURadio out-of-tree module for interfacing with ADALM2000";
      homepage = "https://github.com/analogdevicesinc/gr-m2k";
      license = lib.licenses.gpl3Only;
      platforms = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    };
  }
