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
      porterVersion = "0.57.0";
      system = "aarch64-darwin";
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
    in
    {
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
        
        "jbrockett" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/work
            {
              nixpkgs = {
                overlays = overlays;
                config.allowUnfree = true;
              };
            }
          ];
        };
      };

      # Development shell configuration remains the same
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          nil
          alejandra
          nixfmt
          statix
        ];
      };
    };
}
