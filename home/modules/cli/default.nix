{ pkgs, lib, ... }:

{
  imports = [
    ./apps.nix
    ./starship.nix
    ./zsh.nix
  ];
}