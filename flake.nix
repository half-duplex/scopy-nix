{
  description = "Scopy software oscilloscope and supporting packages";

  #inputs.nixpkgs.url = "nixpkgs/nixos-unstable";
  inputs.nixpkgs.url = "nixpkgs/nixos-25.11";

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    nixpkgsFor = forAllSystems (system:
      import nixpkgs {
        inherit system;
        overlays = [self.overlays.default];
      });
  in {
    formatter = forAllSystems (
      system: nixpkgs.legacyPackages.${system}.alejandra
    );

    overlays.default = final: prev: let
      inherit (final) callPackage;
    in {
      genalyzer = callPackage ./packages/genalyzer.nix {};
      libm2k = callPackage ./packages/libm2k {};
      scopy = callPackage ./packages/scopy.nix {};
      gnuradioPackages = prev.gnuradioPackages.overrideScope (gpfinal: gpprev: {
        m2k = callPackage ./packages/gnuradio-modules/m2k.nix {};
        scopy = callPackage ./packages/gnuradio-modules/scopy.nix {};
      });
      libsForQt5 = prev.libsForQt5.overrideScope (qtfinal: qtprev: {
        qwt-multiaxes = callPackage ./packages/qwt-multiaxes.nix {};
      });
    };

    packages = forAllSystems (system: let
      pkgs = nixpkgsFor.${system};
    in {
      inherit (pkgs) genalyzer libm2k scopy;
      gnuradioPackages = {inherit (pkgs.gnuradioPackages) m2k scopy;};
      libsForQt5 = {inherit (pkgs.libsForQt5) qwt-multiaxes;};
      default = self.packages.${system}.scopy;
    });
  };
}
