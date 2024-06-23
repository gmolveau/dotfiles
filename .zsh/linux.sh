if [[ "${OSTYPE}" != "linux-gnu"* ]]; then
    return 1
fi
source "${HOME}/.zsh/linux/aliases.sh"
source "${HOME}/.zsh/linux/aliases.sh"
source "${HOME}/.zsh/linux/exports.sh"
source "${HOME}/.zsh/linux/functions.sh"

if [ "${RUNNING_OS}" == "ubuntu" ]; then
    source "${HOME}/.zsh/ubuntu.sh"
fi
