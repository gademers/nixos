{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    rustc
    cargo
    pkg-config
    xorg.libX11
    xorg.libXft
    xorg.libXrender
    freetype
    fontconfig
  ];
}
