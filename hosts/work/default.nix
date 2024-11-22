{ lib, pkgs, ... }:

{
  imports = [ ../../home/shared.nix ];

  home = {
    username = "jeremybrockett";
    homeDirectory = "/Users/jbrockett";
    stateVersion = "24.05";
    packages = with pkgs; [
      # Work-specific packages
      google-chrome
      iterm2
      slack
      tableplus
      zoom-us
    ];
  };
}