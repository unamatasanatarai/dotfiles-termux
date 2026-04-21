#!/usr/bin/env bash

# Prompt for Android permissions first (Better UX)
termux-setup-storage
termux-wake-lock

# Basic bootstrap requirements
pkg update -y
pkg upgrade -y
pkg install git make -y

# Smart cloning logic
REPO_URL="https://github.com/unamatasanatarai/dotfiles-termux"
REPO_DIR="dotfiles-termux"

# If we are NOT already inside the repo folder, try to clone it
if [[ ! -f "Makefile" ]]; then
    if [[ ! -d "$REPO_DIR" ]]; then
        git clone "$REPO_URL"
    fi
    cd "$REPO_DIR" || exit
fi

# Hand off the rest to the Makefile
make