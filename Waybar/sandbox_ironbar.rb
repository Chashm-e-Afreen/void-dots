#!/usr/bin/env ruby

xdg = ENV.fetch("XDG_RUNTIME_DIR") { abort "XDG_RUNTIME_DIR not set" }
home = ENV.fetch("HOME") { abort "HOME not set" }

args = [
  "bwrap",
  "--ro-bind", "/usr/bin/dbus-send", "/usr/bin/dbus-send",
  "--ro-bind", "/usr/bin/dbus-launch", "/usr/bin/dbus-launch",
  "--ro-bind", "/usr/bin/dbus-daemon", "/usr/bin/dbus-daemon",
  "--ro-bind", "/usr/bin/waybar", "/usr/bin/waybar",
  "--ro-bind", "/usr/lib", "/usr/lib",
  "--symlink", "/usr/lib", "/lib",
  "--symlink", "/usr/lib", "/usr/lib64",
  "--ro-bind", "/usr/share/dbus-1", "/usr/share/dbus-1",
  "--ro-bind", "/usr/share/X11/xkb", "/usr/share/X11/xkb",
  "--ro-bind", File.join(home, "Sandboxes", "Waybar", "fonts"), "/usr/share/fonts",
  "--ro-bind", "/bin/sh", "/bin/sh",
  "--bind", xdg, xdg,
  "--ro-bind-try", "/var/lib/dbus/machine-id", "/var/lib/dbus/machine-id",
  "--dev-bind", "/dev/null", "/dev/null",
  "--tmpfs", "/tmp",
  "--ro-bind", File.join(home, "Sandboxes", "Waybar", "passwd"), "/etc/passwd",
  "--bind", File.join(home, "Sandboxes", "Waybar", "config"), File.join(home, ".config", "waybar"),
  "--unshare-all",
  "--unshare-user",
  "--unshare-net",
  "--unshare-pid",
  "--die-with-parent",
  "dbus-launch", "waybar"
]

system(*args)
