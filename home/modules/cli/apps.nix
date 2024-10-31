{ pkgs, ... }:

let
  enableWithZshIntegration = {
    enable = true;
    enableZshIntegration = true;
  };
in
{
  home = {
    packages = with pkgs; [
      awscli2
      bat
      curl
      devbox
      docker-compose
      gh
      git
      k9s
      kubectl
      kubectx
      kubernetes-helm
      starship
      zsh
      zsh-autocomplete
      zsh-syntax-highlighting
    ];
  };
}
