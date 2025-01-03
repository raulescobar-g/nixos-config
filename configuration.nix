{ config, pkgs, inputs, ... }: let
  themes = pkgs.callPackage ./sddm/sddm.nix {};
in 
{
  imports =
    [ 
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
    ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "raulescobar" = import ./home.nix; 
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Bootloader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    pulseaudio = {
      enable = false;
      support32Bit = true;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    sensor.iio = {
      enable = true;
    };

    keyboard.qmk = {
      enable = true;
    };

    amdgpu.initrd.enable = true;
  };

  security = {
    rtkit.enable = true;
  };

  services.blueman.enable = true;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.raulescobar = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Raul Escobar";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      wget
      git
      libnotify
      libinput
    ];
  };
  programs.zsh.enable = true;

  programs.hyprland = { 
    xwayland.enable = true;
    enable = true;
    withUWSM = true;
  };

  programs._1password = {
    enable = true;
  };

  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = ["raulescobar"];
  };
  
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services= {
    xserver = {
      enable = false;
    };

    power-profiles-daemon = {
      enable = true;
    };

    fwupd.enable = true;

    displayManager = {
      autoLogin = {
        enable = false;
        user = "raulescobar";
      };
      sddm = {
        enable = true;
        wayland.enable = true;
        autoLogin.relogin = false;
        theme = "oxocarbon-sddm-theme";
      };
    };

    fprintd = {
      enable = true;
    };

    udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="8156", ATTR{power/autosuspend}="20"
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="32ac", ATTRS{idProduct}=="0012", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';

  };

  systemd = {
    services = { 
      fprintd = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig.Type = "simple";
      };
      "getty@tty1".enable = false;
      "autovt@tty1".enable = false;
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    libsForQt5.qt5.qtquickcontrols2   
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtsvg
    themes.oxocarbon-sddm-theme
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.AllowUsers = [ "raulescobar" ];
    authorizedKeysFiles = ["/home/raulescobar/.ssh"];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

}
