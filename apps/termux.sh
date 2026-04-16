#!/usr/bin/env bash

pkg install termux-api -y
ln -sf "$PWD/apps/.termux-properties" "$HOME/.termux/termux.properties"

# disable MOTD, 2 ways
touch "$HOME/.hushlogin"
:> "$PREFIX/etc/motd"
