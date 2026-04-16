#!/usr/bin/env bash

pkg install vim -y
ln -sf "$PWD/apps/.vimrc" "$HOME/.vimrc"
