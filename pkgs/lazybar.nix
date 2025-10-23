{ pkgs, src }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "lazybar";
  version = "git";

  inherit src;
  cargoLock = src + "/Cargo.lock";

}
