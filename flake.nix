{
  description = "My Nix configuration";

  inputs = {
    # Package sources
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    let
      # Systems supported
      supportedSystems = [ "aarch64-darwin" ];
      
      # Helper to create per-system attributes
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
      
      # Create pkgs for each system
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      
      # Create unstable pkgs for each system
      unstablePkgsForSystem = system: import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          # Add porter overlay
          (final: prev: {
            porter = final.callPackage ./pkgs/porter {
              version = "0.57.5";
            };
          })
        ];
      };
    in
    {
      homeConfigurations = {
        # Personal configuration
        jeremy = home-manager.lib.homeManagerConfiguration {
          pkgs = unstablePkgsForSystem "aarch64-darwin";
          modules = [ ./hosts/personal/default.nix ];
        };

        # Gloo configuration
        jeremybrockett = home-manager.lib.homeManagerConfiguration {
          pkgs = unstablePkgsForSystem "aarch64-darwin";
          modules = [ ./hosts/gloo/default.nix ];
        };
      };
    };
}
