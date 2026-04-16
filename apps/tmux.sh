#!/usr/bin/env bash

pkg install tmux -y
mkdir -p "$HOME/.config/tmux"
ln -sf "$PWD/apps/tmux.conf" "$HOME/.config/tmux/tmux.conf"
