{ lib, pkgs, ... }:

let
  importAll = imports: lib.foldl' lib.concat [ ] (map import imports);
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
    allowUnfreePredicate = _: true;
  };

  programs = {
    home-manager.enable = true;
  };
}
