#!/usr/bin/env ruby

xdg = ENV.fetch("XDG_RUNTIME_DIR") { abort "XDG_RUNTIME_DIR not set" }
pwd = script_dir = __dir__
home_dir = ENV.fetch("HOME") { abort "HOME not set" }

sandboxed_home = "/home/appuser"

args = [
  "bwrap",
  "--unshare-all",
  "--unshare-user",
  "--unshare-net",
  "--new-session",
  "--ro-bind", "/lib/ld-musl-x86_64.so.1", "/lib/ld-musl-x86_64.so.1",
  "--ro-bind", "/lib/libgcc_s.so.1", "/lib/libgcc_s.so.1",
  "--ro-bind", "/lib/liblz4.so.1", "/lib/liblz4.so.1",
  "--ro-bind", "/usr/bin/swww-daemon", "/usr/bin/swww-daemon",
  "--ro-bind", "/usr/bin/swww", "/usr/bin/swww",
  "--ro-bind", "/usr/bin/bash", "/usr/bin/bash",
  "--dev-bind", "/dev/null", "/dev/null",
  "--bind", xdg, xdg,
  "--ro-bind", File.join(pwd, "bg.jpg"), "/run/bg.jpg",
  "--tmpfs", sandboxed_home,
  "--setenv", "HOME", sandboxed_home,
  "--bind", File.join(pwd, "cache"), File.join(sandboxed_home, ".cache", "swww"),
  "swww-daemon", 
]

system(*args)
