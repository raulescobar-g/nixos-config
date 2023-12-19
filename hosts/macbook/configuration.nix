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
        autohide-delay = 0.0;
        orientation = "bottom";
        tilesize = 48;
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
    skhd = {
      enable = true;
      skhdConfig = ''
        ctrl - j: yabai -m window --focus south
        ctrl - k: yabai -m window --focus north
        ctrl - h: yabai -m window --focus west
        ctrl - l: yabai -m window --focus east
        ctrl + alt - q: yabai --stop-service
        ctrl + alt - s: yabai --start-service
        cmd - j: yabai -m space --focus west
      '';
    };
  };

  environment.pathsToLink = [ "/share/zsh" ];
  nixpkgs.config.allowUnfree = true;


  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
