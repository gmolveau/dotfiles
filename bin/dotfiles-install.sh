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
else
    echo "Unsupported OS: ${OS}"
    exit 1
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

# backup existing zshrc, if any, just in case
test -f ~/.zshrc && cp ~/.zshrc ~/.zshrc.bck

# clone the dotfiles first so ~/.zsh/ (config + copied plugins) exists
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

# install the git-backed plugins into ~/.zsh/plugins/ (oh-my-zsh no longer used)
mkdir -p "${HOME}/.zsh/plugins"
for plugin in "zsh-users/zsh-autosuggestions" "zsh-users/zsh-completions" "zsh-users/zsh-syntax-highlighting"; do
    dest="${HOME}/.zsh/plugins/$(basename "${plugin}")"
    test -d "${dest}" && continue
    echo "Installing plugin: ${plugin}"
    git clone --quiet "https://github.com/${plugin}" "${dest}"
done

# switch to zsh
sudo chsh -s "$(which zsh)" "$(whoami)"

echo "Please reboot"
