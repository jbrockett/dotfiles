{ lib, pkgs, ... }:

{
  imports = [ ../../home/shared.nix ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "jeremy";
    homeDirectory = "/Users/jeremy";
    stateVersion = "24.11";
    packages = with pkgs; [
      # Personal-specific packages
    ];
  };

  home.enableNixpkgsReleaseCheck = false;
}