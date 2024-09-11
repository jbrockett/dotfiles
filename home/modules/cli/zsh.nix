{ pkgs, lib, ... }:

{
  programs.zsh = {
    autosuggestion.enable = true;
    defaultKeymap = emacs;
    enable = true;
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
    };
    syntaxHighlighting.enable = true;
  };
}
