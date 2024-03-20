{
  config,
  pkgs,
  ...
}: {
  home = {
    homeDirectory =
      if pkgs.stdenv.isLinux
      then "/home/jeremy"
      else "/Users/jeremy";

    packages = with pkgs; [
      bat
      zsh
    ];

    stateVersion = "23.11";
    username = "jeremy";
  };

  programs.home-manager.enable = true;
}
