{
  description = "My Nix configuration";

  inputs = {
    # Package sources
    nixpkgs.url = "nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      system = "aarch64-darwin";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            porter = final.callPackage ./pkgs/porter { 
              version = "0.57.4";
            };
          })
        ];
      };
    in {
      homeConfigurations = {
        "jeremy" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/personal
            {
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };
        
        "jeremybrockett" = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/gloo
            {
              nixpkgs.config.allowUnfree = true;
            }
          ];
        };
      };

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
