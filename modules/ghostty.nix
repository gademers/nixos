{ pkgs, ... }:

{

  programs.ghostty = {
    enable = true;
    package = pkgs.unstable.ghostty;
  };

  environment.variables = {
    TERMINAL = "ghostty";
  };
}
