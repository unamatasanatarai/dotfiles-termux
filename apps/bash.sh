#!/usr/bin/env bash

pkg install bash -y
ln -sf "$PWD/apps/.bashrc" "$HOME/.bashrc"
