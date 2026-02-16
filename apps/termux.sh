#!/usr/bin/env bash

cp apps/.termux-properties "$HOME/.termux/"
# disable MOTD, 2 ways
touch "$HOME/.hushlogin"
:> "$PREFIX/etc/motd"
