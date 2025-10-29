{ config, lib, pkgs, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      ./modules/steam.nix
      #./modules/firefox.nix
      #./modules/ghostty.nix
    ];

  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-framework";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  time.timeZone = "America/Toronto";


  services = {
    displayManager = {
      ly.enable = true;
    };
    xserver = {
      enable = true;
      autoRepeatDelay = 200;
      autoRepeatInterval = 35;
      windowManager.qtile.enable = true;
      windowManager.oxwm.enable = true;
      windowManager.leftwm.enable = true;
    };
    picom.enable = true;
    #for nixos-framework
    pipewire = {
      enable = true;
      pulse.enable = true;
      alsa.enable = true;
      wireplumber.enable = true;
    };
    blueman.enable = true;
  };

  security.rtkit.enable = true; #for audio priority in CPU

  users.users.smee = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ];
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    alacritty
    fzf
    ghostty

    #for nixos-framework
    brightnessctl
  ];

  programs.firefox.enable = true;
  environment.variables = {
    TERMINAL = "ghostty";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

}

