{ config, pkgs, inputs, ... }:

{
  # imports = [ <home-manager/nix-darwin> ];

  users.users.raulescobar = {
    name = "raulescobar";
    home = "/Users/raulescobar";
  };
  
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ 
    pkgs.hello  
  ];
  environment.pathsToLink = [ "/share/zsh" ];
  nixpkgs.config.allowUnfree = true;
  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "$HOME/.config/hosts/macbook/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  programs.zsh.enable = true;  # default shell on catalina

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
