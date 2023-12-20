{ config, pkgs, ... }:
let
  berkeley-mono = pkgs.callPackage ../font/berkeley-mono.nix {};
in 
{
  home.username = "raulescobar_g";
  home.homeDirectory = "/home/raulescobar_g";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  # hi  
  wayland = {
    windowManager = {
      hyprland = {
	enable = true;
	enableNvidiaPatches = true;
	sourceFirst = true;
	extraConfig = ''
	  monitor=,highres,auto,1
 
	  # See https://wiki.hyprland.org/Configuring/Keywords/ for more
 
	  # Execute your favorite apps at launch
	  # exec-once = waybar & hyprpaper & firefox
 
	  # Source a file (multi-file configs)
	  # source = ~/.config/hypr/myColors.conf
 
	  # Some default env vars.
	  env = XCURSOR_SIZE,24
 
	  # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
	  input {
	    kb_layout = us
	    kb_variant =
	    kb_model =
	    kb_options =
	    kb_rules =
 
	    follow_mouse = 1
	    touchpad {
	      natural_scroll = no
	    }
 
	    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
	  }
 
	  general {
	    # See https://wiki.hyprland.org/Configuring/Variables/ for more
 
	    gaps_in = 5
	    gaps_out = 20
	    border_size = 2
	    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
	    col.inactive_border = rgba(595959aa)
 
	    layout = dwindle
	  }
 
	  decoration {
	    # See https://wiki.hyprland.org/Configuring/Variables/ for more
 
	    # rounding = 10
	    # blur = yes
	    # blur_size = 3
	    # blur_passes = 1
	    # blur_new_optimizations = on
 
	    drop_shadow = yes
	    shadow_range = 4
	    shadow_render_power = 3
	    col.shadow = rgba(1a1a1aee)
	  }
 
	  animations {
	    enabled = yes
 
	    bezier = myBezier, 0.05, 0.9, 0.1, 1.05
 
	    animation = windows, 1, 7, myBezier
	    animation = windowsOut, 1, 7, default, popin 80%
	    animation = border, 1, 10, default
	    animation = borderangle, 1, 8, default
	    animation = fade, 1, 7, default
	    animation = workspaces, 1, 6, default
	  }
	  dwindle {
	    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
	    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in
	    preserve_split = yes # you probably want this
	  }
 
	  master {
	    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
	    new_is_master = true
	  }
 
	  gestures {
	    # See https://wiki.hyprland.org/Configuring/Variables/ for more
	    workspace_swipe = off
	  }
 
	  # Example per-device config
	  # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
	  device:epic-mouse-v1 {
	    sensitivity = -0.5
	  }
 
	  # Example windowrule v1
	  # windowrule = float, ^(kitty)$
	  # Example windowrule v2
	  # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
	  # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
 
 
	  # See https://wiki.hyprland.org/Configuring/Keywords/ for more
	  $mainMod = SUPER
 
	  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
	  bind = $mainMod, Q, exec, kitty
	  bind = $mainMod, C, killactive, 
	  bind = $mainMod, M, exit, 
	  bind = $mainMod, E, exec, dolphin
	  bind = $mainMod, V, togglefloating, 
	  bind = $mainMod, R, exec, wofi --show drun
	  bind = $mainMod, P, pseudo, # dwindle
	  bind = $mainMod, J, togglesplit, # dwindle
 
	  bind = $mainMod, S, exec, rofi -show drun -show-icons
	  
	  # Move focus with mainMod + arrow keys
	  bind = $mainMod, left, movefocus, l
	  bind = $mainMod, right, movefocus, r
	  bind = $mainMod, up, movefocus, u
	  bind = $mainMod, down, movefocus, d
	  
	  # Switch workspaces with mainMod + [0-9]
	  bind = $mainMod, 1, workspace, 1
	  bind = $mainMod, 2, workspace, 2
	  bind = $mainMod, 3, workspace, 3
	  bind = $mainMod, 4, workspace, 4
	  bind = $mainMod, 5, workspace, 5
	  bind = $mainMod, 6, workspace, 6
	  bind = $mainMod, 7, workspace, 7
	  bind = $mainMod, 8, workspace, 8
	  bind = $mainMod, 9, workspace, 9
	  bind = $mainMod, 0, workspace, 10
	  
	  # Move active window to a workspace with mainMod + SHIFT + [0-9]
	  bind = $mainMod SHIFT, 1, movetoworkspace, 1
	  bind = $mainMod SHIFT, 2, movetoworkspace, 2
	  bind = $mainMod SHIFT, 3, movetoworkspace, 3
	  bind = $mainMod SHIFT, 4, movetoworkspace, 4
	  bind = $mainMod SHIFT, 5, movetoworkspace, 5
	  bind = $mainMod SHIFT, 6, movetoworkspace, 6
	  bind = $mainMod SHIFT, 7, movetoworkspace, 7
	  bind = $mainMod SHIFT, 8, movetoworkspace, 8
	  bind = $mainMod SHIFT, 9, movetoworkspace, 9
	  bind = $mainMod SHIFT, 0, movetoworkspace, 10
	  
	  # Scroll through existing workspaces with mainMod + scroll
	  bind = $mainMod, mouse_down, workspace, e+1
	  bind = $mainMod, mouse_up, workspace, e-1
	  
	  # Move/resize windows with mainM:wod + LMB/RMB and dragging
	  bindm = $mainMod, mouse:272, movewindow
 	  bindm = $mainMod, mouse:273, resizewindow	    
	'';
	systemd = {
	  enable = true;
	};
	xwayland = {
	  enable = true;
	};
      };
    };
  };  
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    berkeley-mono
    pfetch
  ];

  home.file = { };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    renix = "sudo nixos-rebuild switch --flake .#nixos";
    ls = "eza";
    cat = "bat";
    cd = "z";
    ll = "eza -l -g --icons --git";
    llt = "eza -1 --icons --tree --git-ignore";
    sf = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim";
    code = "nvim";
    grep = "rg";
    pfetch = "PF_ASCII=\"Linux\" pfetch";
    clear = "clear && pfetch";
  };

  programs = {
    home-manager = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      initExtra = ''
      	eval "$(starship init zsh)"
        PF_ASCII="Linux" pfetch
      '';
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
    kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      environment = { "KITTY_ENABLE_WAYLAND"="1"; };
      font = {
        package = berkeley-mono;
        name = "Berkeley Mono";
        size = 24;
      };
      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
      };
      settings = {
        allow_remote_control = true;
	macos_traditional_fullscreen = true;
	dynamic_background_opacity = true;
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
        foreground = "#ffffff";
        background = "#161616";
        background_opacity = "0.8";
        background_blur = 0;
        selection_foreground = "#161616";
        selection_background = "#ee5396";
        color0 = "#262626";
        color8 = "#393939";
        color1 = "#ee5396";
        color9 = "#ee5396";
        color2 = "#42be65";
        color10 = "#42be65";
        color3 = "#ffe97b";
        color11 = "#ffe97b";
        color4 = "#33b1ff";
        color12 = "#33b1ff";
        color5 = "#ff7eb6";
        color13 = "#ff7eb6";
        color6 = "#3ddbd9";
        color14 = "#3ddbd9";
        color7 = "#dde1e6";
        color15 = "#ffffff";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        character = {
          success_symbol = "[λ](bold #BE95FF)";  
          error_symbol = "[λ](bold blue)";
          vimcmd_symbol = "[∇](bold green)";
        };
        cmd_duration = {
          min_time = 10000;
          format = "took [$duration]($style)";
          style = "bold bright-black";
        };
        directory = {
          style = "bold #be95ff";
          truncation_length = 5;
          format = "[$path]($style)[$lock_symbol]($lock_style) ";
          disabled = true; 
        };
        git_branch = {
          format = "∃ [$branch]($style)";
          style = "bold #be95ff";
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
          disabled = true;
        };
        username = {
          show_always = false;
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
    zellij = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep = {
      enable = true;
    };
    eza = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      # colors = {};
    };
    bat = {
      enable = true;
      config = {
        theme = "dracula";
      };
      themes = {
         dracula = {
            src = pkgs.fetchFromGitHub {
              owner = "dracula";
              repo = "sublime"; # Bat uses sublime syntax for its themes
              rev = "26c57ec282abcaa76e57e055f38432bd827ac34e";
              sha256 = "019hfl4zbn4vm4154hh3bwk6hm7bdxbr1hdww83nabxwjn99ndhv";
            };
            file = "Dracula.tmTheme";
         };
      };
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "Berkeley Mono 16";
      location = "center";
    };

  };

}
