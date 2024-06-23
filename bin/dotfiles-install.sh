#!/usr/bin/env bash
set -o errexit
set -o pipefail
set -o nounset
# set -o xtrace

OS=$(uname)
if [ "$OS" = "Linux" ]; then
    INSTALL="sudo apt-get install -y -q"
elif [ "$OS" = "Darwin" ]; then
    INSTALL="brew install"
fi

! command -v "git" &> /dev/null && {
    echo "git is not installed."
    echo "Please install and configure at least the email and the name."
    exit 1
}

! command -v "zsh" &> /dev/null && {
    echo "zsh is not installed. Installing..."
    ${INSTALL} zsh
}

test -d ~/.oh-my-zsh || {
    echo "oh-my-zsh is not installed. Installing..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

# backup zshrc config just in case
cp ~/.zshrc ~/.zshrc.bck

# install custom theme
curl -L -o "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/themes/gregouz.zsh-theme" https://gist.githubusercontent.com/gmolveau/9b6d98ca0ea5ae897a034c4c1d717e81/raw/6f107ee36987126446b4346fe3efc841a9a87484/gregouz.zsh-theme

# install plugins
for plugin in "zsh-users/zsh-autosuggestions" "zsh-users/zsh-completions" "zsh-syntax-highlighting"; do
    git clone --quiet "https://github.com/${plugin}" "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/$(basename $plugin)"
done

# clone the repo
git clone --bare git@github.com:gmolveau/dotfiles.git "${HOME}/.dotfiles"
# ignore everything to avoid accidentally committing things
echo "*" >> "${HOME}/.dotfiles/info/exclude"
# declare the alias for the script
dotfiles="/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}"
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout -f

echo "Please reboot"
