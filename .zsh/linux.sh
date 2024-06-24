if [ "$(uname)" != "Linux" ]; then
    return 1
fi
source "${HOME}/.zsh/linux/aliases.sh"
source "${HOME}/.zsh/linux/aliases.sh"
source "${HOME}/.zsh/linux/exports.sh"
source "${HOME}/.zsh/linux/functions.sh"

if [ "${OS}" == "ubuntu" ]; then
    source "${HOME}/.zsh/ubuntu.sh"
fi
