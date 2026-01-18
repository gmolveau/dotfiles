#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

echo "Install the dotfiles first > https://github.com/gmolveau/dotfiles ;)"

install() {
    sudo apt-get install -y -q --no-install-recommends "$@"
}

# update / upgrade
sudo apt-get update -y
sudo apt-get upgrade -y

# basic tools
BASIC_TOOLS=(
    tree
    zip
    scrot
    gparted
    curl
    wget
    nano
    vim
    terminator
    ghostscript
    ffmpeg
)
install "${BASIC_TOOLS[@]}"

# tmux
install tmux
[ ! -d ~/.tmux/plugins/tpm ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# ssh
[ ! -f ~/.ssh/id_ed25519 ] && ssh-keygen -q -C "" -N "" -t ed25519 -f ~/.ssh/id_ed25519

# 1Password
install gnupg2
wget https://downloads.1password.com/linux/debian/amd64/stable/1password-latest.deb -O /tmp/1password.deb
sudo apt install /tmp/1password.deb
rm /tmp/1password.deb

# Visual Studio Code
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O /tmp/vscode.deb
sudo apt install /tmp/vscode.deb
rm /tmp/vscode.deb

# signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
wget -O-  https://updates.signal.org/static/desktop/apt/signal-desktop.sources | sudo tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null
sudo apt-get update -y && install signal-desktop

# docker
curl -fsSL https://get.docker.com -o /tmp/get-docker.sh
sudo sh /tmp/get-docker.sh
rm /tmp/get-docker.sh

# python
install python3-dev python3-venv

# nodejs
curl -sL https://deb.nodesource.com/setup_24.x -o /tmp/nodesource_setup.sh
sudo bash /tmp/nodesource_setup.sh
install nodejs
rm /tmp/nodesource_setup.sh

# databases
install sqlitebrowser postgresql-client

# chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb
sudo apt install /tmp/chrome.deb
rm /tmp/chrome.deb

# VLC
install vlc

# UV
curl -LsSf https://astral.sh/uv/install.sh | sh

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# claude
curl -fsSL https://claude.ai/install.sh | bash
