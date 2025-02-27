{ lib, pkgs, ... }:

let
  importAll = paths: builtins.concatMap import paths;
in
{
  imports = importAll [
    ./home/modules/cli
    ./home/modules/editors
  ];

  home = {};

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
    package = pkgs.nix;
  };
}
