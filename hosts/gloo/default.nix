{ lib, pkgs, ... }:

{
  imports = [ ../../home/shared.nix ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "jeremybrockett";
    homeDirectory = "/Users/jeremybrockett";
    stateVersion = "24.05";
    packages = with pkgs; [
      # Work-specific packages
      porter
    ];
  };

  home.enableNixpkgsReleaseCheck = false;
}