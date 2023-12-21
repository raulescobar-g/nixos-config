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
        window_animation_frame_rate = 120;
        window_shadow = true;
        window_opacity = true;
        active_window_border_color = "0xFF88C0D0";
        normal_window_border_color = "0x002E3440";
        insert_feedback_color = "0xFFA3BE8C";
        window_border = true;
        mouse_modifier = "cmd";
        top_padding = 12;
        bottom_padding = 12;
        right_padding = 12;
        left_padding = 12;
        window_gap = 12;
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
        cmd - l: yabai -m space --focus next
        cmd - h: yabai -m space --focus prev 
        cmd - m: yabai -m window --toggle zoom-fullscreen
        cmd - c: yabai -m window --close
      '';
    };
    sketchybar = {
      enable = true;
      config = ''
        color = 0xffffffff
        position = top
      '';
    };
  };
  

  environment.pathsToLink = [ "/share/zsh" ];
  nixpkgs.config.allowUnfree = true;


  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
