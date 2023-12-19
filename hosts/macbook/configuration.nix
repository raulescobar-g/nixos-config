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
    description = "Raul Escobar Garcia";
    shell = pkgs.zsh;
  };

  time = {
    timeZone = "America/Chicago";
  };

  system = {
    defaults = {
      finder = {
        CreateDesktop = false;
      };
      dock = {
        show-recents = false;
        autohide = true;
        autohide-delay = 0.24;
        orientation = "bottom";
        tilesize = 32;
        static-only = true;
      };
    };
  };

  
  environment.systemPackages = with pkgs;  [ 
    coreutils
    discord
    spotify
    prismlauncher
  ];

  services = {
    yabai = {
      enable = true;
      enableScriptingAddition = true;
      config = {
        mouse_follows_focus = false;
        focus_follows_mouse = true;
        window_shadow = true;
        window_opacity = true;
        mouse_modifier = "cmd";
        top_padding = 10;
        bottom_padding = 10;
        right_padding = 10;
        left_padding = 10;
        window_gap = 10;
        layout = "bsp";
      };
    };
  };

  environment.pathsToLink = [ "/share/zsh" ];
  nixpkgs.config.allowUnfree = true;


  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
