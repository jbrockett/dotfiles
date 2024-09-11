{ pkgs, lib, ... }:

{
  programs.zsh = {
    autosuggestion.enable = true;
    enable = true;
    initExtra = ''
      bindkey -e
    '';
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    syntaxHighlighting.enable = true;
  };
}
