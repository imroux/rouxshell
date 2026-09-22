hl.on("hyprland.start", function ()
  -- Clipboard config
  hl.exec_cmd("uwsm app -- wl-paste --type text --watch cliphist store") -- Stores only text data
  hl.exec_cmd("uwsm app -- wl-paste --type image --watch cliphist store") -- Stores only image data

  -- Polkit
  hl.exec_cmd("uwsm app -- systemctl --user start hyprpolkitagent")

  -- Applets and daemons
  hl.exec_cmd("uwsm app -- awww-daemon")
  hl.exec_cmd("uwsm app -- bluetoothctl power on")
  -- hl.exec_cmd("uwsm app -- nm-applet --indicator")

  -- Idle configuration
  hl.exec_cmd("uwsm app -- hypridle")

  -- Bar
  -- hl.exec_cmd("~/.config/quickshell/quickshell-restart.sh")

  -- Fix wifi shutting down when laptop lid opens
  hl.exec_cmd("uwsm app -- bash -c 'sudo /etc/rc.d/rc.local'")

  -- Fix dolphin mimetypes associations
  hl.exec_cmd("uwsm app -- dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland")

  -- Restart mpd
  hl.exec_cmd("uwsm app -- systemctl restart --user mpd")
end)
