#!/usr/bin/env bash

pkg install openssh -y

KEY_TYPE="ed25519"                # ed25519 or ecdsa or rsa
KEY_BITS=""                       # only used for rsa or ecdsa (leave empty for ed25519)
KEY_NAME="id_${KEY_TYPE}"         # filename →  ~/.ssh/id_ed25519
COMMENT="$(whoami)@$(hostname) - $(date +%Y-%m)"   # helpful comment
PASSPHRASE=""                     # ← empty = no passphrase
                                  #    "my-very-good-passphrase" = protected key

# Where to store the key (full path)
KEY_FILE="${HOME}/.ssh/${KEY_NAME}"

# ────────────────────────────────────────────────
#  Always deploy config and boot script
# ────────────────────────────────────────────────

install -d -m 700 "${HOME}/.ssh"
install -d -m 700 "${HOME}/.termux/boot"
cp apps/termux-boot-start-sshd "$HOME/.termux/boot/start-sshd"

[[ -f "$PREFIX/etc/ssh/sshd_config.bkp" ]] || \
    mv "$PREFIX/etc/ssh/sshd_config" "$PREFIX/etc/ssh/sshd_config.bkp"
cp "apps/sshd_config" "$PREFIX/etc/ssh/sshd_config"

# ────────────────────────────────────────────────
#  Key generation (skip if key already exists)
# ────────────────────────────────────────────────

if [[ -f "${KEY_FILE}" || -f "${KEY_FILE}.pub" ]]; then
    echo "SSH key already exists → ${KEY_FILE}, skipping keygen."
else

    cmd=(ssh-keygen
        -t "${KEY_TYPE}"
        -f "${KEY_FILE}"
        -N "${PASSPHRASE}"
        -q                      # quiet
    )

    if [[ -n "${KEY_BITS}" ]]; then
        cmd+=( -b "${KEY_BITS}" )
    fi

    if [[ -n "${COMMENT}" ]]; then
        cmd+=( -C "${COMMENT}" )
    fi

    echo "Generating SSH key: ${KEY_FILE}"
    echo "     Type     : ${KEY_TYPE}${KEY_BITS:+ ($KEY_BITS bits)}"
    echo "     Comment  : ${COMMENT}"
    echo "     Passphrase: ${PASSPHRASE:+protected}${PASSPHRASE:-none}"
    echo ""

    "${cmd[@]}"

    if [[ -f "${KEY_FILE}" && -f "${KEY_FILE}.pub" ]]; then
        chmod 600 "${KEY_FILE}"
        chmod 644 "${KEY_FILE}.pub"
        echo
        echo "Success!"
        echo "Private key →  ${KEY_FILE}"
        echo "Public key  →  ${KEY_FILE}.pub"
        echo
        head -n 1 "${KEY_FILE}.pub"
    else
        echo "Something went wrong – key files not created." >&2
    fi

fi
