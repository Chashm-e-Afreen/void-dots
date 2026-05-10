#!/usr/bin/env ruby

xdg = ENV.fetch("XDG_RUNTIME_DIR") { abort "XDG_RUNTIME_DIR not set" }
pwd = __dir__
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
  "--ro-bind", "/usr/bin/awww-daemon", "/usr/bin/awww-daemon",
  "--ro-bind", "/usr/bin/awww", "/usr/bin/awww",
  "--ro-bind", "/usr/bin/sh", "/usr/bin/sh",
  "--ro-bind", "/usr/bin/sleep", "/usr/bin/sleep",
  "--ro-bind", "/usr/bin/mkdir", "/usr/bin/mkdir",
  "--symlink", "/usr/bin/sh", "/bin/sh",
  "--dev-bind", "/dev/null", "/dev/null",
  "--bind", xdg, xdg,
  "--setenv", "XDG_RUNTIME_DIR", xdg,
  "--ro-bind", File.join(pwd, "bg.jpg"), "/run/bg.jpg",
  "--tmpfs", sandboxed_home,
  "--setenv", "HOME", sandboxed_home,
  "--dir", "#{sandboxed_home}/.cache/awww",
  "/usr/bin/sh", "-c", "awww-daemon & sleep 0.2 && awww img /run/bg.jpg && wait"
]
system(*args)
