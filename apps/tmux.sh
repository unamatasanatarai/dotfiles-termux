#!/usr/bin/env bash

pkg install tmux -y
mkdir -p "$HOME/.config/tmux"
cp apps/tmux.conf "$HOME/.config/tmux/"
