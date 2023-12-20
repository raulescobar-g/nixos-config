{ config, pkgs, ... }:
let
  berkeley-mono = pkgs.callPackage ../font/berkeley-mono.nix {};
in 
{
  programs.home-manager.enable = true;
  home.username = "raulescobar_g";
  home.homeDirectory = "/home/raulescobar_g";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.
  
  
  # The home.packages option allows you to install Nix packages into your
  # environment.
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
    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      defaultKeymap = "vicmd";

      initExtra = ''
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
        scrollback_lines = 10000;
        enable_audio_bell = false;
        update_check_interval = 0;
        foreground = "#ffffff";
        background = "#161616";
        background_opacity = "0.5";
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
      settings = {
        theme = "custom";
        themes = {
          custom = {
            fg = "#ffffff";
            bg = "#161616";
          };
        };
      };
    };
    ripgrep = {
      enable = true;
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
    };
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      font = "Berkeley Mono 16";
      location = "center";
    };
    eww = {
      enable = true;

    };   

  };

}
