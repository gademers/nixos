{
  description = "NixOS for Smee";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #flake-utils = {
    #  url = "github:numtide/flake-utils";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    oxwm = {
      url = "github:tonybanters/oxwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, oxwm, rust-overlay, ... }:

    let
      system = [ "x86_64-linux" ];
      pkgs = import nixpkgs {
        inherit system;
        overlays =
          [ rust-overlay.overlay ];
      };
    in

    {

      devShells.${system}.suckless = pkgs.mkShell {
        # toolchain + headers/libs
        # nix develop .#suckless
        packages = with pkgs; [
          pkg-config
          xorg.libX11
          xorg.libXft
          xorg.libXinerama
          fontconfig
          freetype
          harfbuzz
          gcc
          gnumake
        ];
      };

      nixosConfigurations.nixos-framework = nixpkgs.lib.nixosSystem {
        inherit system; #system = system;
        modules = [
          ./configuration.nix
          oxwm.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.smee = import ./home.nix;
              backupFileExtension = "backup";
            };
          }

        ];
      };
    };
}
