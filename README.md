# dotfiles-termux

Termux configuration for mobile home devices — bootstraps packages, SSH, tmux, vim, and bash in one command.

<div align="center">
  <img src="qr-code.png" width="280" alt="QR Code" />
  <p><b>Scan QR to clone repo</b></p>
</div>

## ✨ Features

- **Automated Bootstrap**: One command to set up your entire environment.
- **SSH Ready**: Pre-configures `sshd` with auto-start on boot.
- **Developer Tools**: Includes `tmux`, `vim`, `git`, `curl`, and `shfmt`.
- **Sensible Defaults**: Pre-configured `.bashrc`, `.vimrc`, and `.tmux.conf`.
- **Android Integration**: Quick setup for storage access and wake lock.

## 🚀 First-time setup

1. Install **[Termux](https://termux.dev)** via F-Droid (not Play Store).
2. Run the following commands:

```sh
pkg update -y && pkg upgrade -y
termux-setup-storage
termux-wake-lock
pkg install git make -y
git clone https://github.com/unamatasanatarai/dotfiles-termux
cd dotfiles-termux
make
```

> [!IMPORTANT]
> When prompted by Android, grant **Storage permission** for `termux-setup-storage`.

## 🔄 Management

### Re-applying changes
To sync changes made in the repository (re-links scripts and config files) or refresh packages:
```sh
make update
```

### Structure
- `preflight/` — Initial system setup (upgrade, storage).
- `apps/`      — App installers and configuration symlinking.
- `bin/`       — Helper scripts symlinked to `~/bin`.

## 🛠️ Customization

1. Create `apps/myapp.sh` — `pkg install myapp -y` + symlink any config files.
2. Add `source apps/myapp.sh` to `apps/all.sh`.

## ❓ Q&A

**How do I access SD card storage?**
```sh
cd ~/storage
ln -s /storage/0123-4567 sdcard   # replace 0123-4567 with your actual SD card ID
ls ~/storage/sdcard
```
*Note: Get the SD card ID from a file manager like Total Commander.*
