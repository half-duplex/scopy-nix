{
  lib,
  fetchFromGitHub,
  stdenv,
  cmake,
  fftw,
  libm2k,
}: let
  version = "0.1.4";
in
  stdenv.mkDerivation {
    pname = "genalyzer";
    inherit version;

    src = fetchFromGitHub {
      owner = "analogdevicesinc";
      repo = "genalyzer";
      rev = "v${version}";
      hash = "sha256-bpXyeoslUhc+5NQO/etX0KSTkeBFAUd4maxCzgERR50=";
    };

    buildInputs = [
      fftw
      libm2k
    ];
    nativeBuildInputs = [
      cmake
    ];

    meta = {
      description = "Library of DSP functions for RF measurements";
      homepage = "https://analogdevicesinc.github.io/genalyzer/master";
      license = lib.licenses.gpl2Only;
      platforms = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    };
  }
