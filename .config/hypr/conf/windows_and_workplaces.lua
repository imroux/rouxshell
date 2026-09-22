local suppressMaximizeRule = hl.window_rule({
  -- Ignore maximize requests from all apps. You'll probably like this.
  name  = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
  -- Fix some dragging issues with XWayland
  name  = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },

  no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--   name  = "no-anim-overlay",
--   match = { namespace = "^my-overlay$" },
--   no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },

  move  = "20 monitor_h-120",
  float = true,

})

hl.window_rule({
  match = { class = "steam_app_1284210" }, immediate = true
})

hl.window_rule({
  match = { class = "steam_app_2357570" }, immediate = true
})

-- =============================================================================
-- WORKSPACE RULES
-- =============================================================================
-- Bind workspaces 1-9 to HDMI-A-1, with workspace 1 as default
for i = 1, 9 do
  hl.workspace_rule({
    workspace = i,
    monitor = "HDMI-A-1",
    default = (i == 1) or nil
  })
end

-- Bind workspace 10 to internal monitor
hl.workspace_rule({
  workspace = 10,
  monitor = "eDP-1"
})

-- =============================================================================
-- WINDOW RULES
-- =============================================================================

-- Ignore maximize requests from apps
hl.window_rule({
  match = { class = ".*" },
  suppress_event = "maximize"
})

-- Fix dragging issues with XWayland
hl.window_rule({
  match = {
    class = "^$",
    title = "^$",
    xwayland = true,
    float = true,
    fullscreen = false,
    pin = false
  },
  no_focus = true
})

-- Shared layout for centered dialog boxes (80% width/height)
local large_centered_dialog = {
  float = true,
  size = "monitor_w*0.8 monitor_h*0.8",
  center = true
}

-- Apply large centered dialog rule to specific classes and titles
local dialog_classes = {
  ".blueman-manager-wrapped",
  "org.pulseaudio.pavucontrol",
  "file-png", "file-jpg", "file-jpeg", "file-webp",
  "org.freedesktop.impl.portal.desktop.kde"
}

local dialog_titles = {
  "wants to save",
  "Save File",
  "Choose Mod",
  "Open"
}

for _, class in ipairs(dialog_classes) do
  hl.window_rule({ match = { class = "^(" .. class .. ")$" }, float = large_centered_dialog.float, size = large_centered_dialog.size, center = large_centered_dialog.center })
end

for _, title in ipairs(dialog_titles) do
  hl.window_rule({ match = { title = title }, float = large_centered_dialog.float, size = large_centered_dialog.size, center = large_centered_dialog.center })
end

-- Generic Float Window Rules
local float_only_rules = {
  { class = "^()$", title = "^(Save File)$" },
  { class = "^()$", title = "^(Open File)$" },
  { class = "^(xdg-desktop-portal-gtk|xdg-desktop-portal-kde|xdg-desktop-portal-hyprland)(.*)$" },
  { class = "^(polkit-gnome-authentication-agent-1|hyprpolkitagent|org.org.kde.polkit-kde-authentication-agent-1)(.*)$" },
  { class = "^(CachyOSHello)$" },
  { class = "^(zenity)$" },
  { class = "^()$", title = "^(Steam - Self Updater)$" },
  { title = "^(imv|mpv|danmufloat|termfloat|nemo|ncmpcpp)$" },
  { title = "File Operation Progress" }
}

for _, rule in ipairs(float_only_rules) do
  hl.window_rule({ match = rule, float = true })
end

-- Centered Float Window Rules
hl.window_rule({ match = { class = "^(AmneziaVPN)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(qalculate-gtk)$" }, float = true, center = true })
hl.window_rule({ match = { class = "^(Brave)$" }, center = true })
hl.window_rule({ match = { class = "^()$", title = "^(Open File)$" }, center = true })
hl.window_rule({ match = { title = "Google" }, size = "monitor_w*0.8 monitor_h*0.8", center = true })

-- Tile Windows
hl.window_rule({ match = { title = "Gitnuro" }, tile = true })

-- Opacity Rules
hl.window_rule({ match = { class = "^(thunar|nemo|org.kde.dolphin)$" }, opacity = 0.95 })
hl.window_rule({ match = { class = "^(VSCodium|code-oss|cursor)$" }, opacity = 0.8 })
hl.window_rule({ match = { class = "^(discord|armcord|webcord|vesktop)$" }, opacity = 0.9 })
hl.window_rule({ match = { title = "^(QQ|Telegram)$" }, opacity = 0.8 })
hl.window_rule({ match = { title = "^(NetEase Cloud Music Gtk4)$" }, opacity = 0.8 })
hl.window_rule({ match = { class = "^(obsidian)$" }, opacity = 0.8 })

-- Picture-in-Picture & Special Rules
hl.window_rule({
  match = { title = "^(Picture-in-Picture)$" },
  float = true,
  size = "640 360",
  move = "monitor_w-660 monitor_h-380",
  focus_on_activate = false,
  no_initial_focus = true,
  pin = true
})

hl.window_rule({ match = { title = "^(danmufloat)$" }, pin = true })
hl.window_rule({ match = { title = "^(danmufloat|termfloat)$" }, rounding = 5 })
hl.window_rule({ match = { class = "^(org.mozilla.firefox)$" }, no_blur = true })
hl.window_rule({ match = { class = "Rofi" }, no_blur = true })

-- KDE/Dolphin Prompts (Stay Focused & Pinned)
local kde_prompts = {
  { title = "^(File Already Exists — Dolphin)$" },
  { title = "^(Folder Already Exists — Dolphin)$" },
  { title = "^(Already Exists as Folder — Dolphin)$" },
  { title = "^(Password — Dolphin)$" },
  { title = "^(Information — Dolphin)$" }
}
for _, prompt in ipairs(kde_prompts) do
  hl.window_rule({ match = prompt, stay_focused = true, pin = true })
end
hl.window_rule({ match = { class = "^(org.kde.kded6)$" }, stay_focused = true })

-- Screen Sharing Workaround (XWayland Applications)
hl.window_rule({
  match = { class = "^(xwaylandvideobridge)$" },
  opacity = "0.0 override",
  no_anim = true,
  no_initial_focus = true,
  max_size = "1 1",
  no_blur = true,
  no_focus = true
})

-- IntelliJ Flickering Fix
hl.window_rule({ match = { class = "(jetbrains-.*)" }, no_initial_focus = true })

-- =============================================================================
-- LAYER RULES (Uncomment if needed)
-- =============================================================================
-- hl.layer_rule({ match = { namespace = "logout_dialog" }, animation = "slide top" })
-- hl.layer_rule({ match = { namespace = "waybar" }, animation = "popin 50%" })
-- hl.layer_rule({ match = { namespace = "waybar" }, animation = "slide down" })
-- hl.layer_rule({ match = { namespace = "wallpaper" }, animation = "fade 50%" })
-- hl.layer_rule({ match = { namespace = "rofi" }, animation = "slide top" })
