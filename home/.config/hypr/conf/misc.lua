
hl.config({
  misc = {
    force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(

    font_family = "Hack Nerd Font",
    splash_font_family = "Hack Nerd Font",

    always_follow_on_dnd = true,
    layers_hog_keyboard_focus = true,
    animate_manual_resizes = false,

    enable_swallow = true,
    swallow_regex =
        "^(cachy-browser|firefox|Brave-browser|nautilus|nemo|thunar|ghostty|mpv|alacritty|terminator|btrfs-assistant.)$",

    focus_on_activate = true,
    vrr = 1,
    middle_click_paste = false,
  },

  -- Disable update notifications
  ecosystem = {
    no_update_news = true,
  },
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

