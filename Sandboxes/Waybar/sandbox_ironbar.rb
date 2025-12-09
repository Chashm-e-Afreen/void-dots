#!/usr/bin/env ruby

xdg = ENV.fetch("XDG_RUNTIME_DIR") { abort "XDG_RUNTIME_DIR not set" }
niri = ENV.fetch("NIRI_SOCKET") { abort "NIRI_SOCKET not set" }
wayland = ENV.fetch("WAYLAND_DISPLAY") { abort "WAYLAND_DISPLAY not set" }
home = ENV.fetch("HOME") { abort "HOME not set" }
pwd = script_dir = __dir__

args = [
  "bwrap",
  "--ro-bind", "/usr/bin/dbus-daemon", "/usr/bin/dbus-daemon",
  "--ro-bind", "/usr/bin/dbus-run-session", "/usr/bin/dbus-run-session",
  "--ro-bind", "/usr/bin/waybar", "/usr/bin/waybar",
  "--ro-bind", "/usr/libexec/xdg-desktop-portal", "/usr/libexec//xdg-desktop-portal",
  "--ro-bind", "/usr/lib", "/usr/lib",
  "--symlink", "/usr/lib", "/lib",
  "--symlink", "/usr/lib", "/usr/lib64",
  "--ro-bind", "/usr/share/dbus-1", "/usr/share/dbus-1",
  "--ro-bind", "/usr/share/X11/xkb", "/usr/share/X11/xkb",
  "--ro-bind", File.join(home, "Sandboxes", "Waybar", "fonts"), "/usr/share/fonts",
  "--ro-bind", "/bin/sh", "/bin/sh",
  "--ro-bind", niri, niri,
  "--ro-bind", "#{xdg}/#{wayland}", "#{xdg}/#{wayland}",
  "--ro-bind-try", "/var/lib/dbus/machine-id", "/var/lib/dbus/machine-id",
  "--dev-bind", "/dev/null", "/dev/null",
  "--tmpfs", "/tmp",
  "--ro-bind", File.join(pwd, "passwd"), "/etc/passwd",
  "--bind", File.join(pwd, "config"), File.join(home, ".config", "waybar"),
  "--unshare-all",
  "--unshare-user",
  "--unshare-net",
  "--unshare-pid",
  "--die-with-parent",
  "dbus-run-session", "waybar"
]

system(*args)
