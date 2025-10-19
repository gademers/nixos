{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    python3Packages.psutil
    vscode
    thunar
    pavucontrol
    xfce4-power-manager
    nitrogen
    flameshot
    alsa-utils
    xorg.xbacklight
    networkmanagerapplet
  ];
}
