{ config, pkgs, ... }:

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
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    kitty
    zellij
    zsh
    starship
    pfetch
    zoxide
    bat
    ripgrep
    eza
    fzf
    config.nixpkgs.config.berkeley-mono
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
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/raulescobar_g/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    
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
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
        size = 12;
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
  };
}
