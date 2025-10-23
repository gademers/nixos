{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";
    alacritty = "alacritty";
    rofi = "rofi";
    nvim = "nvim";
    picom = "picom";
    dmenu = "dmenu";

  };
in

{
  imports = [
    ./modules/neovim.nix
    ./modules/suckless.nix
    ./modules/qtile.nix
  ];

  home.username = "smee";
  home.homeDirectory = "/home/smee";
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    userName = "gademers";
    userEmail = "guillaume.demers.gd@gmail.com";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      smeecat = "echo more wet food please? meow";
      nrs = "sudo nixos-rebuild switch --flake ~/nixos#nixos-framework --impure";
    };
    initExtra = ''
          	   export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
      	  '';
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;

  home.packages = with pkgs; [

    ranger
    nix-search-tv

    gcc
    rofi
    bitwarden
    tealdeer
    xclip
    bat
    steam
    #kruler
    #flameshot
    obsidian
    discord
    brave
    gemini-cli
    torrential
    opencode
    networkmanager_dmenu
    blueman
  ];
}
