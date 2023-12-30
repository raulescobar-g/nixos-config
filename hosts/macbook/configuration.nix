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
  system.activationScripts = {
    postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
  };

  system = {
    defaults = {
      loginwindow = {
        autoLoginUser = "Raul Escobar";
      };
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
        mru-spaces = false;
      };
      trackpad = {
        TrackpadThreeFingerDrag = false;
      };
      
    };
  };

  
  environment.systemPackages = with pkgs;  [ 
    coreutils
    discord
    spotify
  ];

  services = {
    yabai = {
      enable = true;
      enableScriptingAddition = true;
   };
    skhd = {
      enable = true;
    };
    sketchybar = {
      enable = true;
    };
  };
  

  environment.pathsToLink = [ "/share/zsh" ];
  nixpkgs.config.allowUnfree = true;


  services.nix-daemon.enable = true;
  system.stateVersion = 4;
}
