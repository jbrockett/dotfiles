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
      google-chrome
      iterm2
      slack
      tableplus
      zoom-us
    ];
  };

  home.activation = {
    linkDotfiles = lib.hm.dag.entryAfter ["writeBoundary"] ''
      $DRY_RUN_CMD ln -sf $VERBOSE_ARG $newGenPath/home-path $HOME/.nix-profile
    '';
  };
}