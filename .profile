#!/bin/env bash
paths=(\
  $HOME/bin \
  $HOME/.npm_installed/bin \
  $HOME/repo/andrtell/scripts \
)

for p in "${paths[@]}"; do
   PATH=$p:$PATH
done

export PATH

export EDITOR='nvim'

export MOZ_ENABLE_WAYLAND=1
export QT_AUTO_SCREEN_SCALE_FACTOR=1
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_DBUS_REMOTE=1
export GTK_USE_PORTAL=0

export ERL_AFLAGS="-kernel shell_history enabled"

[[ -f $HOME/.env ]] && . $HOME/.env
[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc
