hl.env("XCURSOR_THEME", "Bibata-Modern-Amber")
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Amber")
hl.env("QT_CURSOR_THEME", "Bibata-Modern-Classic")

hl.env("XCURSOR_SIZE", "36")
hl.env("HYPRCURSOR_SIZE", "36")
hl.env("QT_CURSOR_SIZE", "36")

-- Optional: Force Hyprland to set it on startup immediately
hl.exec_cmd("hyprctl setcursor Bibata-Modern-Amber 36")

hl.env("GTK_THEME", "adw-gtk3-dark")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("CLUTTER_BACKEND", "wayland")

hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("NVD_BACKEND", "direct")
hl.env("__GL_GSYNC_ALLOWED", "0")
hl.env("__GL_VRR_ALLOWED", "0")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")

hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_MENU_PREFIX", "arch-")
hl.env("bitdepth", "10")

-- Bind behavior
hl.config({
  binds = {
    allow_workspace_cycles = true,
    workspace_back_and_forth = true,
    workspace_center_on = true,
    movefocus_cycles_fullscreen = true,
    window_direction_monitor_fallback = true,
  },
})

-- XWayland
hl.config({
  xwayland = {
    enabled = true,
    use_nearest_neighbor = true,
    force_zero_scaling = true,
  },
})

-- Rendering
hl.config({
  render = {
    direct_scanout = 2,
    expand_undersized_textures = true,
  },
})
