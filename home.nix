{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";
    alacritty = "alacritty";
    rofi = "rofi";
    nvim = "nvim";
  };
in

{
 #imports = [
  # /etc/home/smee/nixos-dotfiles/modules/neovim.nix
  #];

 home.username = "smee";
  home.homeDirectory = "/home/smee";
  programs.git.enable = true;
  home.stateVersion = "25.05";
  programs.bash = {
    enable = true;
    shellAliases = {
      smeecat = "echo more wet food please? meow";
    };
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/qtile/";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [
    
    #neovim stuff
    neovim
    ripgrep
    nil
    nixpkgs-fmt
    nodejs


    gcc
    rofi
    bitwarden
    bitwarden-cli
    tealdeer
    xclip
    bat
    ];
}
