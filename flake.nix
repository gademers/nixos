{
  description = "NixOS for Smee";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay.url = "github:oxalica/rust-overlay";
    lazybar-src.url = "github:Qelxiros/lazybar";
    flake-utils.url = "github:numtide/flake-utils";

    #mangowc = {
    #  url = "github:DreamMaoMao/mangowc";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

  };

  outputs = { self, nixpkgs, home-manager, rust-overlay, flake-utils, ... }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        #system = "x86_64-linux";
        pkgs = import nixpkgs {
          inherit system;
          overlays =
            [ rust-overlay.overlay ];
        };
        lazybarPkg = pkgs.callPackage ./pkgs/lazybar.nix;
      in

      {

        packages = { lazybar = lazybarPkg; };


        devShells.${system}.suckless = pkgs.mkShell {
          # toolchain + headers/libs
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
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.smee = import ./home.nix;
                backupFileExtension = "backup";
              };
            }

            {
              environment.systemPackages = [ lazybarPkg ];
            }

          ];
        };
      });
}
