{ config, pkgs, inputs, ... }:
{
  imports = [
    inputs.hyprcursor-phinger.homeManagerModules.hyprcursor-phinger
  ];
  nixpkgs.config.allowUnfree = true;

  home.username = "raulescobar";
  home.homeDirectory = "/home/raulescobar";
  home.stateVersion = "24.05"; # Please read the comment before changing.
   
  
  home.packages = with pkgs; [
    inputs.zen-browser.packages."${system}".default
    inputs.ghostty.packages."${system}".default
    #gcc
    #cargo

    unzip
    alsa-utils
    brightnessctl
    networkmanager 
    
    wl-clipboard
    hyprshot
    hyprcursor
    spotify
    spotify-cli-linux
    (nerdfonts.override { fonts = [ "Iosevka" ]; })
    discord
    beekeeper-studio
    whatsapp-for-linux
    python312 #remove after replacing eww/brightness.py
    postgresql_17

    (writeShellScriptBin "toggle-sidebar" (builtins.readFile scripts/toggle-sidebar.sh))
    (writeShellScriptBin "wifi" (builtins.readFile scripts/wifi.sh))
    (writeShellScriptBin "volume" (builtins.readFile scripts/volume.sh))
  ];
  services = {
    dunst = {
      enable = true;
      configFile = ./dunst/dunstrc;
    };
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = true;
        splash_offset = 2.0;
        preload = [ "$HOME/Wallpapers/kitty.png" ];
        wallpaper = [ ", $HOME/Wallpapers/kitty.png" ];
      };
    };
    cliphist = {
      enable = true;
      allowImages = true;
    };
    spotifyd = {
      enable = true;
    };
  };
  programs = {
    home-manager.enable = true; # important dont remove  
    atuin = {
      enable = true;
      daemon.enable = true;
      enableZshIntegration = true;
    };
    spotify-player = {
      enable = true;
    };
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
      config = {};
    };
    hyprcursor-phinger.enable = true;
    ruff = {
      enable = true;
      settings = {};
    };
    eww = {
      enable = true;
      configDir = ./eww;
    };
    wofi = {
      enable = true;
      settings = {
        mode = "drun";
        monitor = "eDP-1";
        location = "top-left";
        #xoffset = 678;
        #yoffset = 310;
        width = 300;
        height = 300;
      };
      style = ''
        @define-color base      #161616; 
        @define-color surface0  #262626; 
        @define-color surface1  #393939; 
        @define-color surface2  #525252; 
        @define-color white0    #dde1e6; 
        @define-color accent    #ff7eb6; 

        *{
            font-family: Iosevka Nerd Font;
            font-size: 15px;
        }

        window {
            background-color: @base;
            border: 2px solid @surface2;
            border-radius: 5px;
            /* animation: slideIn 2s ease-in-out both; */
        } 
        /* Slide In */

        #input {
            margin: 5px;
            border-radius: 5px;
            border: none;
            border-bottom: 3px solid @surface2;
            background-color: @surface0;
            color: @white0;
        }

        #inner-box {
            background-color: @surface0;
        }

        #outer-box {
            margin: 5px;
            padding:20px;
            background-color: @base;
        }

        #scroll {
        }

        #text {
        padding: 5px;
        color: @white0;
        }

        #entry {
            border-radius: 5px;
        }

        #entry:nth-child(even){
            background-color: @surface1;
        }

        #entry:selected {
            background-color: @accent;
        }

        #text:selected {
            color: @base;
        }
      '';
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [ "--cmd cd" ];
    };
    bat = {
      enable = true;
      config = {
        theme = "oxocarbon";
      };
      themes = {
        oxocarbon = {
          src = ./bat; 
          file = "oxocarbon-dark.tmTheme";
        };
      };
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      colors = "always";
      extraOptions = [];
      git = true;
      icons = "always";
    };
    ripgrep = {
      enable = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
      	format = " $git_branch\n $character";
	character = {
          success_symbol = "  [󰴈](bold #ff7eb6)  ";  
          error_symbol = "  [󰴈](bold #ff7eb6)  ";
          vimcmd_symbol = "  [󰴈](bold #ff7eb6)  ";
        };
        cmd_duration = {
          min_time = 10000;
          format = "took [$duration]($style)";
          style = "bold bright-black";
        };
        directory = {
          style = "bold bright-black";
          truncation_length = 5;
          format = "∃ [$path]($style)[$lock_symbol]($lock_style) ";
          disabled = false; 
        };
        git_branch = {
          format = "[$branch]($style)";
          style = "bold bright-black";
        };
        git_commit ={
          commit_hash_length = 8;
          style = "bold white";
        };
        git_state = {
          format = "[\($state( $progress_current of $progress_total)\)]($style) ";
        };
        git_status = {
          conflicted = "≠";
          diverged = "Y";
          modified = "*";
          untracked = "∉";
          up_to_date = "∈";
          style = "bold bright-magenta";
          format = " [$all_status]($style) ";
        };
        hostname = {
          disabled = false;
        };
        username = {
	  format = "[$user]($style)";
	  style_user = "bold white";
	  aliases = {
	    raulescobar = "fw-laptop";
	  };
          show_always = true;
        };
        aws = {
          disabled = true;
        };
        rust = {
          disabled = true;
        };
        docker_context = {
          disabled = true;
        };
        package = {
          disabled = true;
        };
        nodejs = {
          disabled = true;
        };
        lua = {
          disabled = true;
        };
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };

  home.shellAliases = {
    ls = "eza";
    ll = "eza -l -g --git";
    llt = "eza -1 --tree --git-ignore";
    cat = "bat";
    grep = "rg";
    renix = "sudo nixos-rebuild switch --flake ~/nixos-config#default";
  };

  fonts = {
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "Iosevka Nerd Font" ];
        #sansSerif = "";
        #serif = "";
        #emoji = "";
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;

    settings = {
      monitor = ",preferred,auto,auto";
      binde = [
        ", XF86AudioLowerVolume, exec, volume dec"
        ", XF86AudioRaiseVolume, exec, volume inc" 
        ", XF86AudioMute, exec, volume mute" 
        ", XF86MonBrightnessUp, exec, brightnessctl s +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl s 5%-"
      ];
      general = {
        border_size = 1;
        gaps_in = 4;
        gaps_out = 4;
        "col.inactive_border" = "0xff444444";
        "col.active_border" = "0xffffffff";
      };
      decoration = {
        rounding = 4;
        active_opacity = 1.0;
        inactive_opacity = 0.8;
        dim_inactive = true;
        dim_strength = 0.1;
      };
      input = {
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.2;
        };
        kb_options = [ "altwin:swap_alt_win" ];
      };
      
      exec-once = [
        "eww open side-bar"
        "systemctl --user enable --now hyprpaper.service"
        "wl-paste --type text --watch cliphist store" # Stores only text data
        "wl-paste --type image --watch cliphist store" # Stores only image data
      ];
      env = [];

      "$mainMod" = "SUPER";	
      bind = [
        "$mainMod, Q, killactive"	
        "$mainMod, S, exec, wofi --show=drun -i -I" 
        "$mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        "$mainMod, H, workspace, -1"
        "$mainMod, H, exec, echo $(hyprctl activewindow | grep \"workspace: \" | cut -d' ' -f2) >> $EVENTS_DIR/workspaces"

        "$mainMod, L, workspace, +1"
        "$mainMod, L, exec, echo $(hyprctl activewindow | grep \"workspace: \" | cut -d' ' -f2) >> $EVENTS_DIR/workspaces"

        "$mainMod, B, exec, toggle-sidebar"
        "$mainMod, PRINT, exec, hyprshot -m window -c"
        ", PRINT, exec, hyprshot -m output -c" 
        "SHIFT, PRINT, exec, hyprshot -m region" 
      ];
      workspace = [
        "r[1-10], persistent[true]"
      ];
    };
  };

  home.file = { 
    "/home/raulescobar/.config/nvim" = {
      source = ./nvim; 
    };
    "/home/raulescobar/.config/uwsm/env" = {
      text = ''
        export LOCK_DIR="$HOME/.lockfiles"
        export EVENTS_DIR="$HOME/.events"
        export HYPRSHOT_DIR="$HOME/Screenshots"
        export HYPRCURSOR_THEME="phinger"
        export HYPRCURSOR_SIZE=32
      '';
    };
    "/home/raulescobar/.config/ghostty/config" = {
      text = ''
        font-family = Iosevka
        font-size = 16
	theme = Oxocarbon
        shell-integration = zsh
        shell-integration-features = cursor, sudo, title
        window-decoration = false
      '';
    };
    "/home/raulescobar/.config/eza/theme.yml" = {
      text = '' 
        filekinds:
          normal:
            foreground: Blue
          directory:
            foreground: Blue
          symlink:
            foreground: Cyan
          executable:
            foreground: Magenta 
        perms:
          user_read:
            foreground: Yellow
            is_bold: true
          user_write:
            foreground: Red
            is_bold: true
          user_execute_file:
            foreground: Magenta
            is_bold: true
          user_execute_other:
            foreground: Magenta
            is_bold: true
          group_read:
            foreground: Yellow
          group_write:
            foreground: Red
          group_execute:
            foreground: Magenta
          other_read:
            foreground: Yellow
          other_write:
            foreground: Red
          other_execute:
            foreground: Magenta
      '';
    };
  };
  
  home.sessionVariables = {  };
}
