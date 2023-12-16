{ config, pkgs, inputs, ... }:

{
  nix.packages = pkgs.nix;
  # imports = [ <home-manager/nix-darwin> ];


  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  programs.zsh = {
    enable = true;
  };

  environment = {
    shells = with pkgs; [ zsh ];
    loginShell = pkgs.zsh;
  };
  
  users.users.raulescobar = {
    name = "raulescobar";
    home = "/Users/raulescobar";
  };

  
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs;  [ 
    coreutils
  ];

  environment.pathsToLink = [ "/share/zsh" ];
  nixpkgs.config.allowUnfree = true;

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/hosts/macbook/configuration.nix";

  # Auto upgrade nix package and the daemon service.

  services.nix-daemon.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
