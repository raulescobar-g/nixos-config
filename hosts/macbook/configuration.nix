{ config, pkgs, ... }:

{
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

  
  environment.systemPackages = with pkgs;  [ 
    coreutils
    discord
    spotify
    prismlauncher
  ];

  environment.pathsToLink = [ "/share/zsh" ];
  nixpkgs.config.allowUnfree = true;


  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
