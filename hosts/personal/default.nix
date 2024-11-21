{ lib, pkgs, ... }:

{
  imports = [ ../../home/shared.nix ];

  home = {
    username = "jeremy";
    homeDirectory = "/Users/jeremy";
    stateVersion = "24.05";
    packages = with pkgs; [
      # Add personal-specific packages here
      iterm2
      slack
      spotify
      vscode
    ];
  };
}