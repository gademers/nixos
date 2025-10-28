{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    package = pkgs.steam;
    #gamescopeSession.enable = true;
  };

  hardware = {
    graphics.enable = true;
    graphics.enable32Bit = true;
    steam-hardware.enable = true;
  };

}
