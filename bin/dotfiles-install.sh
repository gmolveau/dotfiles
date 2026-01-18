#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

OS=$(uname)
if [ "$OS" = "Linux" ]; then
    sudo apt-get update
    INSTALL="sudo apt-get install -y -q --no-install-recommends"
elif [ "$OS" = "Darwin" ]; then
    INSTALL="brew install"
fi

! command -v "git" &> /dev/null && {
    echo "git is not installed."
    echo "Please install and configure at least the email, name and ssh key."
    exit 1
}

! command -v "zsh" &> /dev/null && {
    echo "zsh is not installed. Installing..."
    ${INSTALL} zsh
}

! command -v "fzf" &> /dev/null && {
    echo "fzf is not installed. Installing..."
    ${INSTALL} fzf
}

test -d ~/.oh-my-zsh || {
    echo "oh-my-zsh is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

# backup zshrc config just in case
cp ~/.zshrc ~/.zshrc.bck

# install plugins
# todo list the plugins from the ~/.zsh/plugins.sh
for plugin in "zsh-users/zsh-autosuggestions" "zsh-users/zsh-completions" "zsh-users/zsh-syntax-highlighting"; do
    test -d "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/$(basename $plugin)" && continue
    echo "Installing plugin: ${plugin}"
    git clone --quiet "https://github.com/${plugin}" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/$(basename $plugin)"
done

test -d "${HOME}/.dotfiles" && {
    echo "Dotfiles repo already exists. Exiting to avoid overwriting."
    exit 1
}

echo "Cloning dotfiles repo..."
git clone --bare git@github.com:gmolveau/dotfiles.git "${HOME}/.dotfiles"
# ignore everything to avoid accidentally committing things
echo "*" >> "${HOME}/.dotfiles/info/exclude"
# declare the alias for the script
dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"
${dotfiles} config --local status.showUntrackedFiles no
${dotfiles} checkout -f

# switch to zsh
chsh -s $(which zsh)

echo "Please reboot"
