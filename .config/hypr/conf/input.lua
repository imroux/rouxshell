hl.config({
  input = {
    kb_layout  = "us,ru",
    kb_variant = "",
    kb_model   = "",
    kb_options = "grp:win_space_toggle, grp:alt_shift_toggle",
    kb_rules   = "",

    follow_mouse = 1,

    accel_profile = "flat",
    sensitivity = 1.0, -- -1.0 - 1.0, 0 means no modification.

    touchpad = {
      natural_scroll = false,
      disable_while_typing = false,
      clickfinger_behavior = false,
      drag_lock = false
    },
  },

  cursor = {
    no_hardware_cursors = true,
    no_warps = true
  }
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace"
})
