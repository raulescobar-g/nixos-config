{ config, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  home.username = "raulescobar";
  home.homeDirectory = "/home/raulescobar";
  home.stateVersion = "24.05"; # Please read the comment before changing.
  
  home.packages = with pkgs; [
    kitty
    swww
    (nerdfonts.override {
      fonts = [
        "Iosevka"
        "IosevkaTerm"
      ];
    })
    discord
    whatsapp-for-linux
    alsa-utils 
    brightnessctl
    ruff
    (pkgs.python312.withPackages (ppkgs: [
      ppkgs.psutil
    ]))
    (writeShellScriptBin "toggle-sidebar" (builtins.readFile scripts/toggle-sidebar.sh))
    (writeShellScriptBin "wifi" (builtins.readFile scripts/wifi.sh))
    networkmanager
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs = {
    home-manager.enable = true; # important dont remove
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
        xoffset = 678;
        yoffset = 310;
        width = 512;
        height = 344;
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
          src = pkgs.fetchFromGitHub {
            owner = "raulescobar-g";
            repo = "oxocarbon-bat-theme"; # Bat uses sublime syntax for its themes
            rev = "124cae2a14eb33c1430e0d3f5742fbd7fd1691ea";
            sha256 = "sha256-e966VDGfPin3r2Mc3avt5mVZaO+HCqSfyNdLGoAWito=";
          };
          file = "oxocarbon-dark.tmTheme";
        };
      };
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
      #colors = "always";
      extraOptions = [];
      #git = true;
      #icons = "always";
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
          success_symbol = "  [󰴈](bold red)  ";  
          error_symbol = "  [󰴈](bold red)  ";
          vimcmd_symbol = "  [󰴈](bold red)  ";
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
    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        default_shell = "zsh";
        simplified_ui = true;
        pane_frames = false;
        default_layout = "compact";
        ui = {
          pane_frames = {
            rounded_corners = true;
            hide_session_name = true;
          };
        };
        theme = "oxocarbon";
        themes = {
          oxocarbon = {
            fg = "#262626";
            bg = "#262626";
            black = "#161616"; #bg fullbar
            red = "#161616";
            green = "#ff7eb6";
            yellow = "#161616";
            blue = "#161616";
            magenta = "#161616";
            cyan = "#161616";
            white = "#ff7eb6";
            orange = "#161616";
          };
        };
      };
    };
    kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = true;
      darwinLaunchOptions = [
        "-o allow_remote_control=yes" 
      ];
      font = {
        size = 14;
        name = "Iosevka Nerd Font";
        package = (pkgs.nerdfonts.override {
          fonts = [
            "Iosevka"
          ];
        });
      };
      environment = { "KITTY_ENABLE_WAYLAND"="1"; };
      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
      };
      settings = {
        allow_remote_control = true;
        macos_traditional_fullscreen = true;
        hide_window_decorations = "titlebar-only";
        window_padding_width = 0;
        dynamic_background_opacity = true;
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
        background_opacity = "1.0";
        background_blur = 0;

	foreground="#dde1e6";
        background="#161616";
        selection_foreground="#f2f4f8";
        selection_background="#525252";
        cursor="#f2f4f8";
        cursor_text_color="#393939";
        url_color="#ee5396";
        url_style="single";
        active_border_color="#ee5396";
        inactive_border_color="#ff7eb6";
        bell_border_color="#ee5396";
        wayland_titlebar_color="system";
        macos_titlebar_color="system";
        active_tab_foreground="#161616";
        active_tab_background="#ee5396";
        inactive_tab_foreground="#dde1e6";
        inactive_tab_background="#393939";
        tab_bar_background="#161616";
        color0="#262626";
        color8="#393939";
        color1="#ff7eb6";
        color9="#ff7eb6";
        color2="#42be65";
        color10="#42be65";
        color3="#82cfff";
        color11="#82cfff";
        color4="#33b1ff";
        color12="#33b1ff";
        color5="#ee5396";
        color13="#ee5396";
        color6="#3ddbd9";
        color14="#3ddbd9";
        color7="#dde1e6";
        color15="#ffffff";
      };
    };
  };

  home.shellAliases = {
    ls = "eza";
    ll = "eza -l -g --git";
    llt = "eza -1 --tree --git-ignore";
    cat = "bat";
    grep = "rg";
    renix = "sudo -u raulescobar nixos-rebuild switch --flake ~/nixos-config#default";
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
    systemd.enable = true;

    settings = {
      monitor = ",preferred,auto,auto";
      binde = [
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+" 
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
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
        "swww-daemon & swww img ~/Wallpaper/kitty.png"
      ];
      env = [
        "XCURSOR_SIZE,36"	
      ];

      "$mainMod" = "SUPER";	
      bind = [
        "$mainMod, Q, killactive"	
        "$mainMod, S, exec, wofi --show=drun -i -I" 
        "$mainMod, H, workspace, -1"
        "$mainMod, L, workspace, +1"
        "$mainMod, B, exec, toggle-sidebar"
      ];
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/raulescobar/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = { 
    LOCK_DIR = "$HOME/.lockfiles";
  };
}
