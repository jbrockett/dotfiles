{
  description = "My Nix configuration";

  inputs = {
    # Package sources
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      porterVersion = "0.56.7";
      system = "aarch64-darwin";
      pkgs = import nixpkgs {  # Modified this line
        inherit system;
        overlays = overlays;  # Added this line
      };
      
      overlays = [
        (final: prev: {
          porter = final.callPackage ./pkgs/porter { 
            version = porterVersion;
          };
        })
      ];
    in
    {
      homeConfigurations.jeremy = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          {
            nixpkgs = {
              overlays = overlays;
              config.allowUnfree = true;
            };
          }
        ];
      };

      # Add development shell
      devShells.aarch64-darwin.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nil
          alejandra
          nixfmt
          statix
        ];
      };
    };
}
