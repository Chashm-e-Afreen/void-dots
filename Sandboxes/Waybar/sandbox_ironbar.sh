#!/bin/bash

bwrap \
  --ro-bind /usr/bin/dbus-send /usr/bin/dbus-send \
  --ro-bind /usr/bin/dbus-launch /usr/bin/dbus-launch \
  --ro-bind /usr/bin/dbus-daemon /usr/bin/dbus-daemon \
  --ro-bind /usr/bin/waybar /usr/bin/waybar \
  --ro-bind /usr/lib /usr/lib \
  --symlink /usr/lib /lib \
  --symlink /usr/lib /usr/lib64 \
  --ro-bind /usr/share/dbus-1 /usr/share/dbus-1 \
  --ro-bind /usr/share/X11/xkb /usr/share/X11/xkb \
  --ro-bind "$HOME/Sandboxes/Waybar/fonts" /usr/share/fonts \
  --ro-bind /bin/sh /bin/sh \
  --bind "$XDG_RUNTIME_DIR" "$XDG_RUNTIME_DIR" \
  --ro-bind-try /var/lib/dbus/machine-id /var/lib/dbus/machine-id \
  --dev-bind /dev/null /dev/null \
  --tmpfs /tmp \
  --ro-bind "$HOME/Sandboxes/Waybar/passwd" /etc/passwd \
  --bind "$HOME/Sandboxes/Waybar/config" "$HOME/.config/waybar" \
  --unshare-all \
  --unshare-user \
  --unshare-net \
  --unshare-pid \
  --die-with-parent \
  dbus-launch waybar

