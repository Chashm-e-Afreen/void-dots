#!/usr/bin/env ruby

xdg = ENV.fetch("XDG_RUNTIME_DIR") { abort "XDG_RUNTIME_DIR not set" }
pwd = Dir.pwd
home = ENV.fetch("HOME") { abort "HOME not set" }

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
  "--ro-bind", "/usr/bin/sleep", "/usr/bin/sleep",
  "--bind", xdg, xdg,
  "--ro-bind", File.join(pwd, "bg.jpg"), "/run/bg.jpg",
  "--ro-bind", File.join(home, "Sandboxes", "Swww", "script.sh"), "/run/script.sh",
  "bash", "/run/script.sh"
]

system(*args)
