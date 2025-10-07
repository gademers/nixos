{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/nixos-dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    qtile = "qtile";
    alacritty = "alacritty";
    rofi = "rofi";
    nvim = "nvim";
    picom = "picom";
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
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-dotfiles#nixos-smee";
    };
    initExtra = ''
    	   export PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"
	  '';
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath};";
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
