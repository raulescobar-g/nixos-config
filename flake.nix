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
<<<<<<< HEAD
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [ 
            ./hosts/nixos/configuration.nix
            home-manager.nixosModules.home-manager {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users."raulescobar_g" = import ./hosts/nixos/home.nix;
              };
            }
=======
        default = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ 
            ./hosts/default/configuration.nix
            home-manager.nixosModules.default
>>>>>>> 7909b0faf5007a0ce7ab6571272e7b264e9f2d05
          ];
        };
      };

      darwinConfigurations = {
        macbook = nix-darwin.lib.darwinSystem {
<<<<<<< HEAD
          specialArgs = inputs;
          system = "aarch64-darwin";
          modules = [ 
            ./hosts/macbook/configuration.nix
            home-manager.darwinModules.home-manager
=======
          inherit inputs;
          system = "aarch64-darwin";
          modules = [ 
            ./hosts/macbook/configuration.nix
            home-manager.darwinModules.default
>>>>>>> 7909b0faf5007a0ce7ab6571272e7b264e9f2d05
          ];
        }; 
      }; 
    };
}
