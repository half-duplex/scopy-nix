{
  lib,
  fetchFromGitHub,
  stdenv,
  boost,
  cmake,
  extra-cmake-modules,
  genalyzer,
  gmp,
  gnuradio,
  gnuradioPackages,
  #kddockwidgets,
  libad9361,
  libiio,
  libm2k,
  libsForQt5,
  libserialport,
  libsigrokdecode,
  matio,
  python3,
  spdlog,
  volk,
}: let
  version = "2.2.0";
in
  stdenv.mkDerivation {
    pname = "scopy";
    inherit version;

    src = fetchFromGitHub {
      owner = "analogdevicesinc";
      repo = "scopy";
      rev = "v${version}";
      hash = "sha256-YTaZRywzTx4MkMEo8qF3gT+I68RP1zumNRAG7CQMftI=";
    };

    buildInputs = [
      libsForQt5.qtbase
      libsForQt5.qttools
      libsForQt5.karchive
      libsForQt5.qt3d
      libsForQt5.qwt-multiaxes
      boost
      genalyzer
      gmp
      gnuradio
      # Doesn't seem needed?
      #(gnuradio.override {
      #  unwrapped = gnuradio.unwrapped.override {
      #    #version = "3.10.000.ad20251209";
      #    overrideSrc = fetchFromGitHub {
      #      owner = "analogdevicesinc";
      #      repo = "gnuradio";
      #      # scopy2-maint-3.10 branch, as of 2026-05-18
      #      # unknown specific gr version
      #      rev = "696841710f0ba38687af0873e4475860bd82da99";
      #      hash = "sha256-SEqmMdceQjkLMw8/RAugWAJmau7lE0HNH1n98pPr7Qo=";
      #    };
      #  };
      #})
      gnuradioPackages.m2k
      gnuradioPackages.scopy
      #iio-emu
      #kddockwidgets # can't use until scopy is qt6
      libad9361
      libiio
      libm2k
      libserialport
      libsigrokdecode
      #libtinyiiod
      matio
      spdlog
      volk
    ];
    nativeBuildInputs = [
      cmake
      extra-cmake-modules
      python3
      libsForQt5.wrapQtAppsHook
    ];

    meta = {
      description = "A software oscilloscope and signal analysis toolset";
      homepage = "https://analogdevicesinc.github.io/scopy/";
      license = lib.licenses.gpl3Only;
      platforms = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    };
  }
