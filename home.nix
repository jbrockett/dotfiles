{ lib, pkgs, ... }:

let
  importAll = paths: builtins.concatMap import paths;
in
{
  imports = importAll [
    ./home/modules/cli
    ./home/modules/editors
  ];

  home = {
    username = "jeremy";
    homeDirectory = "/Users/jeremy";
    stateVersion = "24.05";
    packages = with pkgs; [
      porter
    ];
  };

  news.display = "silent";

  nixpkgs.config = {
    allowUnfree = true;
  };

  programs = {
    home-manager.enable = true;
  };

  nix = {
    settings = {
      auto-optimise-store = true;
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
