# dotfiles-termux

Termux configuration for mobile home devices — bootstraps packages, SSH, tmux, vim, and bash in one command.

## Requirements

- [Termux](https://termux.dev) installed via F-Droid (not Play Store)
- [Termux:Boot](https://f-droid.org/en/packages/com.termux.boot/) installed (for sshd auto-start)
- [Termux:API](https://f-droid.org/en/packages/com.termux.api/) installed

## First-time setup

```sh
pkg install git make -y
git clone https://github.com/unamatasanatarai/dotfiles-termux
cd dotfiles-termux
make
```

> When prompted by Android, grant Storage permission for `termux-setup-storage`.

## Re-applying config changes

To re-install/update app configs without running a full `pkg upgrade`:

```sh
make update
```

## Structure

```
preflight/   # run before apps: upgrade, storage, directories
apps/        # one script per app: install + deploy config
bin/         # scripts symlinked to ~/bin
```

## Adding a new app

1. Create `apps/myapp.sh` — `pkg install myapp -y` + copy any config files
2. Add `source apps/myapp.sh` to `apps/all.sh`

## Q&A

**How do I access SD card storage?**

```sh
cd ~/storage
ln -s /storage/0123-4567 sdcard   # replace 0123-4567 with your actual SD card ID
ls ~/storage/sdcard
```

Get the SD card ID from a file manager (e.g. Total Commander → SD card path).
