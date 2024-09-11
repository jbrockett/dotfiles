users.defaultUserShell=pkgs.zsh;
programs.zsh.enable = true;

#Change the default shell to be user-specific.
users.users.jeremy.shell = pkgs.zsh;

nix.gc = {
  automatic = true;
  dates = "weekly"; 
  options = "--delete-older-than 30d";
};
