#!/usr/bin/env bash
# Bootstrap for a freshly installed Linux machine (user created, nothing else).
# Installs the requirements, then hands over to the Ansible playbook.
#
# Usage: ./bootstrap.sh

set -o errexit
set -o pipefail
set -o nounset

DOTFILES_REPO="${1:-https://github.com/gmolveau/dotfiles}"
readonly DOTFILES_REPO
PLAYBOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PLAYBOOK_DIR

step() { echo "> $1"; }

step "checking for apt"
if ! command -v apt-get &>/dev/null; then
    echo "this bootstrap only supports Debian-based distributions" >&2
    exit 1
fi

step "installing ansible"
sudo apt-get update -y -q
sudo apt-get install -y -q --no-install-recommends ansible

step "installing rust"
if ! command -v cargo &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

step "git identity"
if [ -n "$(git config --global user.name 2>/dev/null || true)" ] && [ -n "$(git config --global user.email 2>/dev/null || true)" ]; then
    echo "  already set: $(git config --global user.name) <$(git config --global user.email)>"
else
    if ! command -v git &>/dev/null; then
        sudo apt-get install -y -q git
    fi
    read -r -p "git user.name: " GIT_NAME
    read -r -p "git user.email: " GIT_EMAIL
    if [ -n "${GIT_NAME}" ]; then git config --global user.name "${GIT_NAME}"; fi
    if [ -n "${GIT_EMAIL}" ]; then git config --global user.email "${GIT_EMAIL}"; fi
fi

step "running the playbook"
printf 'apt tasks will use sudo (cached or prompted on the terminal)\n\n'
ansible-playbook "${PLAYBOOK_DIR}/linux-first-install.yml" -K

echo "linux first install done - please reboot"
