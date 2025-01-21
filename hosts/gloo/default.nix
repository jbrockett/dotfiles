{ lib, pkgs, ... }:

{
  imports = [ ../../home/shared.nix ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "jeremybrockett";
    homeDirectory = "/Users/jeremybrockett";
    stateVersion = "24.11";
    packages = with pkgs; [
      # Work-specific packages
      porter
      # List of GUI applications that I'm not installing via nix yet
      # bruno
      # code-cursor
      # docker # Not sure of the package name
      # iterm2
      # tableplus
    ];
  };

  home.enableNixpkgsReleaseCheck = false;
}