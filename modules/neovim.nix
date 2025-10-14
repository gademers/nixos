{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    #tools for telescope
    ripgrep
    fd
    fzf

    #language servers
    lua-language-server
    nil
    nixpkgs-fmt

    nodejs #needed for lazyvim

  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
