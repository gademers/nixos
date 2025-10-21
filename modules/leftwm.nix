{ config, pkgs, ... }:

{
  # leftwm configuration
  #  home.file.".config/leftwm/config.toml".source = ../config/leftwm/config.toml;
  #  home.file.".config/leftwm/themes/current/theme.toml".source = ../config/leftwm/themes/current/theme.toml;


  # Polybar for the status bar
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      pulseSupport = true;
      nlSupport = true;
    };
    script = "polybar main &";
    config = ../config/polybar/config.ini;
  };

  # Network Manager applet
  home.packages = with pkgs; [
    network-manager-applet
  ];

  # Required packages for leftwm and polybar to function correctly
  environment.systemPackages = with pkgs; [
    feh # For setting the wallpaper
    dmenu #main application launcher
    rofi # For the application launcher
  ];
}
