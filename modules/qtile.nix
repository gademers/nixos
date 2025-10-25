{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    python3Packages.psutil
    pavucontrol
    nitrogen
    flameshot
    alsa-utils
    xorg.xbacklight
    networkmanagerapplet
  ];
}
