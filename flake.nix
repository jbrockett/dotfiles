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

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, flake-utils, ... }@inputs:
    let
      porterVersion = "0.57.0";
      
      # Create a function to generate the configuration for any system
      mkConfig = system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = overlays;
        };
        
        overlays = [
          (final: prev: {
            porter = final.callPackage ./pkgs/porter { 
              version = porterVersion;
            };
          })
        ];
      in {
        homeConfigurations = {
          "jeremy" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./hosts/personal
              {
                nixpkgs = {
                  overlays = overlays;
                  config.allowUnfree = true;
                };
              }
            ];
          };
          
          "jeremybrockett" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              ./hosts/gloo
              {
                nixpkgs = {
                  overlays = overlays;
                  config.allowUnfree = true;
                };
              }
            ];
          };
        };
      };
    in
    (mkConfig "aarch64-darwin") // 
    flake-utils.lib.eachDefaultSystem (system: {
      devShells.default = (import nixpkgs { inherit system; }).mkShell {
        buildInputs = with (import nixpkgs { inherit system; }); [
          nil
          alejandra
          nixfmt
          statix
        ];
      };
    });
}
