#!/usr/bin/env bash
# Bootstrap for a freshly initialized MacBook (user created, nothing else).
# Installs the requirements, then hands over to the Ansible playbook.
#
# Usage: ./bootstrap.sh

set -o errexit
set -o pipefail
set -o nounset

DOTFILES_REPO="${1:-https://github.com/gmolveau/dotfiles}"
readonly DOTFILES_REPO
DOTFILES_DIR="${HOME}/.dotfiles"
readonly DOTFILES_DIR
PLAYBOOK_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PLAYBOOK_DIR

step() { echo "> $1"; }

step "installing Xcode command line tools"
if ! xcode-select -p &>/dev/null; then
    xcode-select --install
    echo "  waiting for the CLT installer to finish..."
    until xcode-select -p &>/dev/null; do sleep 5; done
    echo "  done"
fi

step "installing Homebrew"
if ! command -v brew &>/dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$("$(brew --prefix)/bin/brew" shellenv)"

step "installing ansible"
brew list --formula --quiet | grep -qx "ansible" || brew install ansible

step "installing rust"
if ! command -v cargo &>/dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

step "git identity"
if [ -n "$(git config --global user.name || true)" ] && [ -n "$(git config --global user.email || true)" ]; then
    echo "  already set: $(git config --global user.name) <$(git config --global user.email)>"
else
    read -r -p "git user.name: " GIT_NAME
    read -r -p "git user.email: " GIT_EMAIL
    if [ -n "${GIT_NAME}" ]; then git config --global user.name "${GIT_NAME}"; fi
    if [ -n "${GIT_EMAIL}" ]; then git config --global user.email "${GIT_EMAIL}"; fi
fi

step "installing role dependencies"
ansible-galaxy collection list 2>/dev/null | grep -q "community.general" ||
    ansible-galaxy collection install community.general

step "running the playbook"
printf 'you will now be asked for your sudo password\n\n'
ansible-playbook "${PLAYBOOK_DIR}/macos-first-install.yml" -K

echo "macos first install done - please reboot"
