{ config, pkgs, ... }:
{
  home.username = "raulescobar";
  home.homeDirectory = "/home/raulescobar";
  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    kitty
    swww
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs = {
    home-manager.enable = true; # important dont remove
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
    };
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    bat = {
      enable = true;
    };
    eza = {
      enable = true;
      enableZshIntegration = true;
    };
    ripgrep = {
      enable = true;
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
      	format = "❬$git_branch❭ $character";
	character = {
          success_symbol = "~(bold yellow) [⬤](bold yellow)";  
          error_symbol = "~(bold yellow) [⬤](bold red)";
          vimcmd_symbol = "~(bold yellow) [⬤](bold green)";
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
          style = "bold blue";
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
        theme = "default";
        themes = {
          default = {
            fg = "#fafaf9";
            bg = "#0c0a09";
            black = "#1c1917";
            red = "#dc2626";
            green = "#84cc16";
            yellow = "#eab308";
            blue = "#33b1ff";
            magenta = "#ff7eb6";
            cyan = "#3ddbd9";
            white = "#f5f5f4";
            orange = "#3ddbd9";
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
        name = "Iosevka";
        package = (nerdfonts.override { fonts = [ "Iosevka" ]; });
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
        foreground = "#fafaf9";
        background = "#0c0a09";
        background_opacity = "1.0";
        background_blur = 0;
        selection_foreground = "#f2f4f8";
        selection_background = "#525252";
        cursor = "#f2f4f8";
        cursor_text_color = "#393939";
        url_color = "#eab308";
        url_style = "single";
        active_border_color = "#eab308";
        inactive_border_color = "#ff7eb6";
        bell_border_color = "#ee5396";
        wayland_titlebar_color = "system";
        macos_titlebar_color = "system";
        active_tab_foreground = "#161616";
        active_tab_background = "#ee5396";
        inactive_tab_foreground = "#dde1e6";
        inactive_tab_background = "#393939";
        tab_bar_background = "#161616";

	#black -
        color0 = "#0c0a09";
        color8 = "#1c1917";
	#red -
        color1 = "#dc2626";
        color9 = "#ef4444"; 
	#green -
        color2 = "#84cc16";
        color10 = "#a3e635";
	#yellow -
        color3 = "#eab308";
        color11 = "#facc15"; 
	#blue - 
        color4 = "#78716c";
        color12 = "#a8a29e";
	#magenta - 
        color5 = "#44403c";
        color13 = "#57534e";
	#cyan -
        color6 = "#d6d3d1";
        color14 = "#e7e5e4";
	#white -
        color7 = "#f5f5f4";
        color15 = "#fafaf9";

      };
    };
  };

  home.shellAliases = {
    ls = "eza";
    ll = "eza -l -g --git";
    llt = "eza -1 --tree --git-ignore";
    cat = "bat";
    grep = "rg";
    cd = "z";
    renix = "sudo -u raulescobar nixos-rebuild switch --flake ~/nixos-config#default";
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" ]; }) 
    ]
    fontconfig = {
      enable = true;
      defaultFonts = {
	monospace = "Iosevka";
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

      input = {
	touchpad = {
	  scroll_factor = 0.2;
	};
	kb_options = [ "altwin:swap_alt_win" ];
      };
      
      exec-once = [
	"eww open side-bar --config ~/Documents/ma-bar"
	"swww-daemon & swww img ~/Wallpaper/kitty.png"
      ];
      env = [
	"XCURSOR_SIZE,24"	
      ];

      "$mainMod" = "SUPER";	
      bind = [
	"$mainMod, Q, killactive"	
	"$mainMod, S, exec, rofi -show drun -show-icons" 
	"$mainMod, H, workspace, -1"
	"$mainMod, L, workspace, +1"
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
  home.sessionVariables = { };
}
