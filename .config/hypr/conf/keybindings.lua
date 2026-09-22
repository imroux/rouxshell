
-- Set programs that you use
local terminal    = "kitty"
local fileManager = "nautilus"
local menu        = "hyprlauncher"

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("firefox"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("librewolf"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("zeditor -n"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(terminal .. "-e rmpc"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("shortwave"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("heroic"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("gimp"))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("hyprpicker -ra"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian --disable-gpu"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("pavucontrol -t 3"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("blueman-manager"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("AmneziaVPN"))
hl.bind("F12", hl.dsp.exec_cmd("wtype -k escape"))
hl.bind("F11", hl.dsp.exec_cmd("wtype -k F2"))

local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + CTRL + P", hl.dsp.window.pin())

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m output -m active -s -o $HOME/Data/My/Screenshots"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window -m active -s -o $HOME/Data/My/Screenshots"))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m region --freeze -s -o $HOME/Data/My/Screenshots"))

-- Layout switch
local function safe_layout_msg(target_layout, msg)
  return function()
    local ws = hl.get_active_workspace()
    if ws and ws.tiled_layout == target_layout then
      hl.dispatch(hl.dsp.layout(msg))
    end
  end
end

hl.bind(mainMod .. " + SHIFT + W", function() hl.config({ general = { layout = "dwindle" } }) end)
hl.bind(mainMod .. " + CTRL + W",  function() hl.config({ general = { layout = "master" } }) end)
hl.bind(mainMod .. " + ALT + W",   function() hl.config({ general = { layout = "scrolling" } }) end)
-- Dwindle layout
hl.bind(mainMod .. " + J",         safe_layout_msg("dwindle", "togglesplit"))
hl.bind(mainMod .. " + SHIFT + J", safe_layout_msg("dwindle", "swapsplit"))
hl.bind(mainMod .. " + P",         hl.dsp.window.pseudo(), { description = "Toggle current window pseudo tiling mode" })
-- hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
-- Master layout
hl.bind(mainMod .. " + J",         safe_layout_msg("master", "orientationnext"))
hl.bind(mainMod .. " + SHIFT + J", safe_layout_msg("master", "orientationprev"))
hl.bind(mainMod .. " + CTRL + J",  safe_layout_msg("master", "swapwithmaster"), { description = "Swap current window with master" })

-- Window grouping
hl.bind(mainMod .. " + K", hl.dsp.group.toggle())
hl.bind(mainMod .. " + COMMA",  hl.dsp.group.prev())
hl.bind(mainMod .. " + PERIOD", hl.dsp.group.next())

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod + SHIFT + arrows keys
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + CTRL + [0-9]
-- Move active window to a workspace without switching to that workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
  hl.bind(mainMod .. " + CTRL + " .. key,     hl.dsp.window.move({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i, follow = false }))
end
hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous_per_monitor" }))

hl.bind(mainMod .. " + ESCAPE", hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + ESCAPE", hl.dsp.window.bring_to_top())

-- Special workspaces (scratchpads)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
-- Minimize window
hl.bind(mainMod .. " + X", hl.dsp.workspace.toggle_special("minimagic"))
hl.bind(mainMod .. " + X", hl.dsp.window.move({ workspace = "+0" }))
hl.bind(mainMod .. " + X", hl.dsp.workspace.toggle_special("minimagic"))
hl.bind(mainMod .. " + X", hl.dsp.window.move({ workspace = "special:minimagic" }))
hl.bind(mainMod .. " + X", hl.dsp.workspace.toggle_special("minimagic"))
hl.bind(mainMod .. " + SHIFT + X", hl.dsp.workspace.toggle_special("minimagic"))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Quick window resize
hl.bind("SUPER + CTRL + SHIFT + right", hl.dsp.window.resize({ x = 15, y = 0, relative = true }), { description = "Resize to the right" })
hl.bind("SUPER + CTRL + SHIFT + left", hl.dsp.window.resize({ x = -15, y = 0, relative = true }), { description = "Resize to the left" })
hl.bind("SUPER + CTRL + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -15, relative = true }), { description = "Resize upwards" })
hl.bind("SUPER + CTRL + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 15, relative = true }), { description = "Resize downwards" })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
