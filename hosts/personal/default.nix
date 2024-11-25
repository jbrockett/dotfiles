{ lib, pkgs, ... }:

{
  imports = [ ../../home/shared.nix ];

  home = {
    username = "jeremy";
    homeDirectory = "/Users/jeremy";
    stateVersion = "24.05";
    packages = with pkgs; [
      # Personal-specific packages
    ];
  };
}