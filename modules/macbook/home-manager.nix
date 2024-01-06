{ config, pkgs, lib, ...}:
let 
  berkeley-mono = pkgs.callPackage ../font/berkeley-mono.nix {};
  wallpapa = pkgs.writeShellScriptBin "wallpapa" ''
      #!/usr/bin/env zsh
      WALLPAPER_DIR="$HOME/Wallpapers"
      RANDOM_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)
      /usr/bin/osascript -e "
        tell application \"System Events\"
          tell every desktop
            set picture to \"$RANDOM_WALLPAPER\"
          end tell
        end tell"
    '';
in
{
  home.username = "raulescobar";
  home.homeDirectory = "/Users/raulescobar";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    berkeley-mono
    pfetch
    uwufetch
    wallpapa
    skhd
    (nerdfonts.override { fonts = [ "Hack" ]; })
    spotify-tui
    discordo
    jq
  ];


  home.file = let 
    barHeight= toString 38; 
  in { 
    ".config/sketchybar/plugins/datetime.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env zsh
        sketchybar --set $NAME label="$(date '+%b%d %I%M')"
      '';
    };
    ".config/sketchybar/plugins/desktops.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env zsh
        sketchybar --set $NAME label="$(yabai -m query --spaces --space | jq '.index')"
      '';
    };
    "/.config/sketchybar/plugins/application.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env zsh 
        APP=$(osascript -e 'tell application "System Events" to get name of application processes whose frontmost is true and visible is true')

        sketchybar --set $NAME label=$APP
      '';
    };
    ".config/sketchybar/plugins/cpu.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env zsh
        CPU=$(top -l  2 | grep "^CPU" | tail -1 | awk '{ print int($3 + $5)"c" }')
        sketchybar --set $NAME label="$CPU"
      '';
    };
    ".config/sketchybar/plugins/mem.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env zsh
        MEM=$(top -l  2 | grep "^PhysMem" | tail -1 | awk '{ print $2 }')
        sketchybar --set $NAME label="$MEM"
      '';
    };
    ".config/sketchybar/plugins/volume.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env zsh
        VOLUME=$(osascript -e 'set ovol to output volume of (get volume settings)' | awk '{ print $1"vl" }')
        sketchybar --set $NAME label="$VOLUME"
      '';
    };
    ".config/sketchybar/plugins/battery.sh" = {
      enable = true;
      executable = true;
      text = ''
        #!/usr/bin/env zsh
        PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1 | awk '{ print $1"bt" }')
        sketchybar --set $NAME label="$PERCENTAGE"
      '';
    };
    ".config/sketchybar/sketchybarrc" = {
      enable = true;
      executable = true;
      text = ''
        PLUGINS="$CONFIG_DIR/plugins"
        BAR_HEIGHT=${barHeight}
        BG_PADDING=12
        BG_HEIGHT=$((BAR_HEIGHT-BG_PADDING))

        sketchybar --bar \
          color=0xff161616 \
          shadow=off \
          y_offset=0 \
          corner_radius=0 \
          padding_left=0 \
          padding_right=0 \
          notch_width=190 \
          margin=0 \
          height=$BAR_HEIGHT \
          display=all 
        
        sketchybar --default \
          label.font="Berkeley Mono:Regular:20.0" \
          label.color=0xffdde1e6 \
          label.padding_right=10 \
          label.padding_left=10 \
          icon.font="Hack Nerd Font:Regular:20.0" \
          padding_left=10 \
          padding_right=10 \

        sketchybar --add item time right \
          --set time \
            update_freq=5 \
            script="$PLUGINS/datetime.sh"

        sketchybar --add item separator.1 right \
          --set separator.1 \
            padding_left=2 \
            padding_right=2 \
            label="|"

        sketchybar --add item battery right \
          --set battery \
            script="$PLUGINS/battery.sh" \
            update_freq=10 \
          --subscribe battery system_woke power_source_change 

        sketchybar --add item volume right \
          --set volume \
            script="$PLUGINS/volume.sh" \
          --subscribe volume volume_change
        
        sketchybar --add item separator.2 right \
          --set separator.2 \
            padding_left=2 \
            padding_right=2 \
            label="|"

        sketchybar --add item cpu right \
          --set cpu \
            script="$PLUGINS/cpu.sh" \
            update_freq=10

        sketchybar --add item mem right \
          --set mem \
            script="$PLUGINS/mem.sh" \
            update_freq=10

        sketchybar --add item desktops left \
          --set desktops \
            script="$PLUGINS/desktops.sh" \
          --subscribe desktops space_change display_change

        sketchybar --add item application left \
          --set application \
            script="$PLUGINS/application.sh" \
          --subscribe application front_app_switched space_change space_windows_change display_change

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
        wallpapa
        # borders active_color="glow(0xffffffff)" inactive_color=0xff525252 width=1.0 &

        yabai -m config mouse_follows_focus off 
        yabai -m config focus_follows_mouse autofocus 
        yabai -m config window_shadow off  
        yabai -m config top_padding 12 
        yabai -m config bottom_padding 12  
        yabai -m config right_padding 12  
        yabai -m config left_padding 12  
        yabai -m config window_gap 12  
        yabai -m config external_bar all:${barHeight}:0 
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
    ls = "eza --icons";
    cat = "bat";
    cd = "z";
    ll = "eza -l -g --icons --git";
    llt = "eza -1 --icons --tree --git-ignore";
    sf = "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}' | xargs nvim";
    code = "nvim";
    grep = "rg";
    pfetch = "PF_INFO=\"ascii title os host kernel uptime pkgs memory shell editor wm de palette\" PF_COL1=1 PF_COL2=8 PF_COL3=6 PF_ASCII=\"Linux\" pfetch";
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
        PF_INFO="ascii title os host kernel uptime pkgs memory shell editor wm de palette" PF_COL1=1 PF_COL2=8 PF_COL3=6 PF_ASCII="Linux" pfetch
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
        window_padding_width = 4;
        dynamic_background_opacity = true;
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
        foreground = "#dde1e6";
        background = "#161616";
        background_opacity = "1.0";
        background_blur = 0;
        selection_foreground = "#f2f4f8";
        selection_background = "#525252";
        cursor = "#f2f4f8";
        cursor_text_color = "#393939";
        url_color = "#ee5396";
        url_style = "single";
        active_border_color = "#ee5396";
        inactive_border_color = "#ff7eb6";
        bell_border_color = "#ee5396";
        wayland_titlebar_color = "system";
        macos_titlebar_color = "system";
        active_tab_foreground = "#161616";
        active_tab_background = "#ee5396";
        inactive_tab_foreground = "#dde1e6";
        inactive_tab_background = "#393939";
        tab_bar_background = "#161616";
        color0 = "#262626";
        color8 = "#393939";
        color1 = "#ff7eb6";
        color9 = "#ff7eb6";
        color2 = "#42be65";
        color10 = "#42be65";
        color3 = "#82cfff";
        color11 = "#82cfff";
        color4 = "#33b1ff";
        color12 = "#33b1ff";
        color5 = "#ee5396";
        color13 = "#ee5396";
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
          style = "bold bright-black";
          truncation_length = 5;
          format = "∃ [$path]($style)[$lock_symbol]($lock_style) ";
          disabled = false; 
        };
        git_branch = {
          format = "∊ [$branch]($style)";
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
        default_layout = "compact";
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
