{
  description = "my config flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, ... }@inputs:
    { 
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [ 
            ./hosts/nixos/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."raulescobar_g" = import ./modules/nixos/home-manager.nix;
              };
            }
          ];
        };
      };

      darwinConfigurations = {
        macbook = nix-darwin.lib.darwinSystem {
          specialArgs = inputs;
          system = "aarch64-darwin";
          modules = [ 
            ./hosts/macbook/configuration.nix
            home-manager.darwinModules.home-manager
          ];
        }; 
      }; 
    };
}
