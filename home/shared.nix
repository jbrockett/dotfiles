{ lib, pkgs, ... }:

{
  imports = [
    ./modules/cli
    ./modules/editors
  ];

  news.display = "silent";

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs = {
    home-manager.enable = true;
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      frequency = "weekly";
      options = "--delete-older-than 30d";
    };
    package = pkgs.nix;
  };
}