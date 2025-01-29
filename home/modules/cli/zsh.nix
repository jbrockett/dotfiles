{ pkgs, lib, ... }:

{
  home.file.".zsh/completion/_docker".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker";
    sha256 = "93dfeb5deebba490fcb9a24a9a623f5802dfa6b128536a3b97372740785e564a";
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    initExtra = ''
      # Enable emacs keybindings
      bindkey -e

      # Docker completion
      if [ -f ~/.zsh/completion/_docker ]; then
        fpath=(~/.zsh/completion $fpath)
        autoload -Uz compinit && compinit -i
      fi

      # Improve Docker command completion
      zstyle ':completion:*:*:docker:*' option-stacking yes
      zstyle ':completion:*:*:docker-*:*' option-stacking yes

      # Load AWS CLI zsh completion script
      autoload -Uz compinit
      compinit
      source ${pkgs.awscli2}/share/zsh/site-functions/_aws
    '';
    shellAliases = {
      ll = "ls -l";
      update = "sudo nixos-rebuild switch";
      k = "kubectl";
    };
    syntaxHighlighting.enable = true;
  };
}
