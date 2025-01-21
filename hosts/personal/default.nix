{ lib, pkgs, ... }:

{
  imports = [ ../../home/shared.nix ];

  home = {
    username = "jeremy";
    homeDirectory = "/Users/jeremy";
    packages = with pkgs; [
      # Personal-specific packages
    ];
  };
}