{
  description = "NixOS for Smee";
  inputs = {
    # Core
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR";

    # Tools
    #disko = {
    #  url = "github:nix-community/disko";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    home-manager = {
      url = "github:nix-community/home-manager";
      #url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #deploy-rs = {
    #  url = "github:serokell/deploy-rs";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #impermanence = {
    #  url = "github:nix-community/impermanence";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    #rust-overlay = {
    #  url = "github:oxalica/rust-overlay";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    #Custom Packages
    oxwm = {
      url = "github:tonybanters/oxwm";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, ... }@inputs:

    let
      lib = nixpkgs.lib;


      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays =
          [ inputs.rust-overlay.overlays ];
      };
    in

    {

      nixosConfigurations.nixos-framework = nixpkgs.lib.nixosSystem {
        inherit system; #system = system;

        modules = [
          ./configuration.nix
          inputs.oxwm.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
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
