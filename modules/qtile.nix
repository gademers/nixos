{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    python3Packages.psutil
    pavucontrol
    flameshot
    alsa-utils
    xorg.xbacklight
    networkmanagerapplet
    dunst #notification daemon
    nitrogen #wallpaper manager
  ];
}
