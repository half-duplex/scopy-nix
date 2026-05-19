{
  fetchFromGitHub,
  libsForQt5,
}:
libsForQt5.qwt.overrideAttrs (final: prev: {
  pname = "qwt-multiaxes";
  version = "6.3.0.orso";
  src = fetchFromGitHub {
    owner = "cseci";
    repo = "qwt";
    # qwt-multiaxes-updated
    rev = "34c2c7e45ef7fafb15a9126f0aa71d2c7ad1efcd";
    hash = "sha256-jDoAs5OTM6rKVIqE/B/eSMDHeb8/ClY4ReeEnH2TZ6s=";
  };
})
