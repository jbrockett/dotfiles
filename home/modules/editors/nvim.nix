{ pkgs, lib, ... }:

{
    programs.neovim = {
        defaultEditor = true;
        enable = true;
        extraConfig = lib.fileContents ./init.vim;
        viAlias = true;
        vimAlias = true;
    };
}