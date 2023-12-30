{ config, pkgs, lib, ...}:
let 
  berkeley-mono = pkgs.callPackage ../font/berkeley-mono.nix {};
  wallpapa = pkgs.writeShellScriptBin "wallpapa" ''
      #!/usr/bin/env bash 
      WALLPAPER_DIR="$HOME/Wallpapers"
      RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
      /usr/bin/osascript -e "tell application \"System Events\" to set picture of every desktop to \"$RANDOM_WALLPAPER\""
    '';
in
{
  home.username = "raulescobar";
  home.homeDirectory = "/Users/raulescobar";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  
  fonts.fontconfig.enable = true;
  home.activation = {
    wallpapa = lib.hm.dag.entryAfter["writeBoundary"] ''
      ${wallpapa}/bin/wallpapa
    '';
  };
  

  home.packages = with pkgs; [
    berkeley-mono
    pfetch
    wallpapa
    skhd
    (nerdfonts.override { fonts = [ "Hack" ]; })
  ];


  home.file = { 
    ".config/sketchybar/plugins/datetime.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash
        sketchybar --set $NAME label="$(date '+%F %X')"
      '';
    };
    ".config/sketchybar/plugins/battery.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env bash
        PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
        CHARGING=$(pmset -g batt | grep 'AC Power')

        if [ $PERCENTAGE = "" ]; then
          exit 0
        fi

        case $\{PERCENTAGE\} in
          9[0-9]|100) ICON=" "
        ;;
          [6-8][0-9]) ICON=" "
        ;;
          [3-5][0-9]) ICON=" "
        ;;
          [1-2][0-9]) ICON=" "
        ;;
          *) ICON=" "
        esac

        if [[ $CHARGING != "" ]]; then
          ICON=""
        fi

        sketchybar --set $NAME icon="$ICON" label="$PERCENTAGE%"
      '';
    };
    ".config/sketchybar/sketchybarrc" = {
      enable = true;
      executable = true;
      text = ''
        PLUGINS="$CONFIG_DIR/plugins"

        sketchybar --bar \
          color=0xcc161616 \
          shadow=off \
          y_offset=6 \
          corner_radius=12 \
          padding_left=3 \
          padding_right=3 \
          margin=6 \
          height=48 \
          display=all \
          border_color=0xff3ddbd9 \
          border_width=3 \
          font_smoothing=on \
          blur_radius=3
        
        sketchybar --default \
          padding_left=12 \
          padding_right=12 \
          label.font="Berkeley Mono:Bold:18.0" \
          label.color=0xffffffff \ 
          updates=when_show
          icon.font="Hack Nerd Font:Bold:36.0"

        sketchybar --add item time right \
          --set time \
            update_freq=5 \
            script="$PLUGINS/datetime.sh"

       sketchybar --add item battery right \
          --set battery \
            script="$PLUGINS/battery.sh" \
            update_freq=10 \
          --subscribe battery system_woke power_source_change 

        sketchybar --update
      '';
    };
    ".config/skhd/skhdrc" = {
      enable = true;
      executable = true;
      text = ''
        ctrl - j: yabai -m window --focus south
        ctrl - k: yabai -m window --focus north
        ctrl - h: yabai -m window --focus west
        ctrl - l: yabai -m window --focus east
        cmd - l: yabai -m space --focus next
        cmd - h: yabai -m space --focus prev 
        cmd - m: yabai -m window --toggle zoom-fullscreen
      '';
    };
    ".config/yabai/yabairc" = {
      enable = true;
      executable = true;
      text = ''
        yabai -m config mouse_follows_focus off 
        yabai -m config focus_follows_mouse autofocus 
        yabai -m config window_shadow off  
        yabai -m config top_padding 12 
        yabai -m config bottom_padding 12  
        yabai -m config right_padding 12  
        yabai -m config left_padding 12  
        yabai -m config window_gap 12  
        yabai -m config external_bar all:48:0 
        yabai -m config layout bsp  

        yabai -m rule --add app='System Preferences' manage=off
      '';
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };


  home.shellAliases = {
    renix = "darwin-rebuild switch --flake .#macbook";
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
    suramba = "sudo rm -rf /etc/bashrc /etc/zshenv /etc/zshrc";
  };

  programs = {
    home-manager = {
      enable = true;
    };
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true; # move wallpaper setting to system wide init
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
      darwinLaunchOptions = [
        "-o allow_remote_control=yes" 
      ];
      font = {
        package = berkeley-mono;
	name = "Berkeley Mono";
	size = 24;
      };
      environment = { "KITTY_ENABLE_WAYLAND"="1"; };
      keybindings = {
        "ctrl+c" = "copy_or_interrupt";
      };
      settings = {
        allow_remote_control = true;
        macos_traditional_fullscreen = true;
        hide_window_decorations = "titlebar-only";
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
    eza = {
      enable = true;
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
    zellij = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        default_shell = "zsh";
        simplified_ui = true;
        pane_frames = false;
        # default_layout = "compact";
        ui = {
          pane_frames = {
            rounded_corners = true;
            hide_session_name = true;
          };
        };
        theme = "default";
        themes = {
          default = {
            fg = "#ffffff";
            bg = "#161616";
            black = "#262626";
            red = "#ee5396";
            green = "#3ddbd9";
            yellow = "#ffe97b";
            blue = "#33b1ff";
            magenta = "#ff7eb6";
            cyan = "#3ddbd9";
            white = "#dde1e6";
            orange = "#3ddbd9";
          };
        };
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      # colors = {};
      # many more options can go here
    };
    ripgrep = {
      enable = true;
    };
  };
}
