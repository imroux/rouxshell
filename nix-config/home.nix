{ config, pkgs, ... }:

let
  rouxshellDir = "${config.home.homeDirectory}/.local/share/rouxshell";
in
{
  home.username = "roux";
  home.homeDirectory = "/home/roux";

  home.stateVersion = "26.05";


  home.packages = with pkgs; [
    # CLI Tools
    kitty
    btop
    fastfetch
    tmux
    spotdl
    yt-dlp

    # Development
    zed-editor

    # Browsers
    librewolf

    # Editors
    neovim
    emacs
    libreoffice-fresh

    # Looks and feel
    awww
    rofi
    mako
    gtk3
    gtk4
    matugen
    adwaita-icon-theme
    hyprshot
    hyprlock
    hypridle
    hyprcursor
    hyprpicker
    hyprutils

    # Media
    gimp3
    loupe
    mcomix
    mpv
    rmpc

    # Miscelleneous
    nautilus
    keepassxc
    telegram-desktop
    obsidian
  ];

  programs = {
    firefox.enable = true;
    home-manager.enable = true;
  };

  # Configure Hyprland Window Manager
  wayland.windowManager.hyprland = {
    enable = true;

    # CRITICAL: Prevent HM from creating conflicting systemd services
    systemd.enable = false;
  };

  # GTK theming
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3"; # or "adw-gtk3-dark" for dark mode
      package = pkgs.adw-gtk3;
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # Declaratively configure the cursor
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;

    # Automatically apply it to GTK and X11 configurations
    gtk.enable = true;
    x11.enable = true;
  };

  services.wl-clip-persist = {
    enable = true;
    clipboardType = "regular"; # Options: "regular", "primary", or "both"
  };

  services.cliphist = {
    enable = true;
    allowImages = true; # Set to false if you only want to save text history
  };

#   services.mpd = {
#     enable = true;
#     startWhenNeeded = false;
#
#     # 1. Set the base directory where MPD will naturally house database & state
#     dataDir = "${config.home.homeDirectory}/.local/share/mpd";
#
#     # 2. Replicate your music and playlists directories
#     musicDirectory = "${config.home.homeDirectory}/Data/Media/Music";
#     playlistDirectory = "${config.home.homeDirectory}/.local/share/mpd/playlists";
#
#     # 3. Use settings (or extraConfig) to specifically hardcode the exact filenames
#     # so they perfectly match your Arch Touch script
#     settings = {
#       database = "${config.home.homeDirectory}/.local/share/mpd/database";
#       state_file = "${config.home.homeDirectory}/.local/share/mpd/state";
#       sticker_file = "${config.home.homeDirectory}/.local/share/mpd/sticker.sql";
#     };
#   };
#
#   # Automatically trigger 'mpc update' right after systemd starts MPD
#   systemd.user.services.mpd.Service.ExecStartPost = "${pkgs.mpc-cli}/bin/mpc update";

  # Environment Variables
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    QT_QPA_PLATFORMTHEME = "gtk3";
  };

  # You can write plain text configs or link existing files directly
  # into your ~/.config directory.

  # Example: Creating a basic text file in your home directory
  # home.file.".custom_greeting".text = "Welcome back, master!";

  # Example: Sourcing an existing config into ~/.config/foo/config
  # xdg.configFile."foo/config".source = ./configs/foo_config;

  # Dotfiles & Custom Files (Optional)
  # xdg.configFile."foo/config".source = ./configs/foo_config;
  # home.file.".config" = {
  #   source = ./.local/share/rouxshell;
  #   recursive = true; # Keeps existing files in ~/.config intact and only merges/overwrites yours
  # };

  home.file = {
    ".config" = {
      source = "${rouxshellDir}/.config";
      recursive = true; # Merges instead of wiping out your existing ~/.config
    };

    ".local" = {
      source = "${rouxshellDir}/.local";
      recursive = true; # Merges safely into your existing ~/.local
    };

    ".zshrc".source = "${rouxshellDir}/.zshrc";
    ".face".source = "${rouxshellDir}/.face";
  };
}
