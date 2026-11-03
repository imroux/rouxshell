{ config, pkgs, lib, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-26.05.tar.gz;
in
{
  imports =
    [
      ./hardware-configuration.nix
      "${home-manager}/nixos"
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot = {
    enable = true;
    configurationLimit = 5;
  };

  # Plymouth setup
  boot = {
    plymouth = {
      enable = true;
      theme = "rings";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "rings" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "rd.udev.log_level=3"
      "rd.systemd.show_status=auto"
    ];
  };

  # Automated Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
   # Automatically drops everything except the active generation and what you tell it to keep
    options = "--delete-older-than 7d";
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.initrd.luks.devices."luks-a78da333-af10-4ba0-ad2d-bcf4fe5634d0".device = "/dev/disk/by-uuid/a78da333-af10-4ba0-ad2d-bcf4fe5634d0";
  networking.hostName = "dusk";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Istanbul";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.roux = { pkgs, ... }: {
      home.stateVersion = "26.05";
      imports = [ /home/roux/.local/share/rouxshell/nix-config/home.nix ];
    };
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the Pantheon Desktop Environment.
  services.xserver.displayManager.lightdm.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,ru";
    variant = ",";
    options = "grp:alt_shift_toggle";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  # Optional but recommended for real-time audio priority
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  users.users."roux" = {
    isNormalUser = true;
    description = "Roux";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  users.users.root = {
    shell = pkgs.zsh;
  };

  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    # Shell Utils
    zsh
    zoxide
    fzf
    starship
    lsd
    ripgrep

    neovim
    yazi

    # base-devel equivalents
    gnumake
    gcc
    binutils
    coreutils

    # Version Control & Tools
    lazygit
    wget
    cpio
    unrar
    unzip
    rsync
    tealdeer
    networkmanagerapplet
    ffmpeg-full
    wl-clipboard
    pavucontrol
    playerctl

    # Build Systems
    cmake
    meson
    ninja
    dart-sass

    # Runtimes & Compilers
    go
    luarocks
    deno
    bun

    # LSPs
    rust-analyzer

    # Node Ecosystem
    nodejs             # Installs Node + NPM
    pnpm

    # Python Ecosystem
    uv
    pipx
    (python3.withPackages (ps: with ps; [
      pip
      pygobject3
    ]))
  ];

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.hack
  ];

  # GTK setup
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*"; # Fallback to available portals
  };
  programs.dconf.enable = true;

  # Hyprland setup
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  # Git setup
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Power Management
  services.thermald.enable = true;

  # Virtualization / Containers
  virtualisation.podman.enable = true;

  # Core Utils
  services.locate.enable = true;
  services.gvfs.enable = true;

  # Enable the Syncthing system service
  services.syncthing = {
    enable = true;
    user = "roux";                 # Run under your user account to avoid permission issues
    group = "users";
    openDefaultPorts = true;               # Automatically opens ports 22000/TCP/UDP and 21027/UDP
    dataDir = "/home/roux";
      configDir = "/home/roux/.config/syncthing";
  };

  # Fix wifi shutting down when laptop lid is closed
  systemd.services.fix-laptop-lid-wifi = {
    description = "Fix laptop lid acting like airplane mode key";

    # Ensure the service runs at boot when the system is initializing components
    wantedBy = [ "multi-user.target" ];

    # A oneshot service runs the script once and exits
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "fix-lid" ''
        ${pkgs.kbd}/bin/setkeycodes d7 240
        ${pkgs.kbd}/bin/setkeycodes e058 142
      '';
    };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?
}
