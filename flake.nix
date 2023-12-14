{
  description = "my config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    { 
      nixosConfigurations = {
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages."x86_64-linux";

        default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hosts/default/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        };
      };
      darwinConfigurations = {
        system = "aarch64-darwin";
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";

        macbook  = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
            ./hosts/macbook/configuration.nix
            inputs.home-manager.nixosModules.default
          ];
        }; 
      }; 
    };
}
