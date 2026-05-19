{
  lib,
  fetchFromGitHub,
  stdenv,
  bison,
  boost,
  cmake,
  flex,
  gmp,
  gnuradio,
  spdlog,
  volk,
}: let
  version = "1.0.0";
in
  stdenv.mkDerivation {
    pname = "gr-scopy";
    inherit version;

    src = fetchFromGitHub {
      owner = "analogdevicesinc";
      repo = "gr-scopy";
      rev = "v${version}";
      hash = "sha256-8jR0jUsIJUVmS3T89MuqL9lyFWN36brmYz73Jja3Vwo=";
    };

    buildInputs = [
      boost
      gmp
      gnuradio
      spdlog
      volk
    ];
    nativeBuildInputs = [
      bison
      cmake
      flex
    ];

    meta = {
      description = "Scopy IIO blocks for GNU Radio";
      homepage = "https://github.com/analogdevicesinc/gr-scopy";
      license = lib.licenses.gpl3Only;
      platforms = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    };
  }
