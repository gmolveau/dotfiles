# ohmyzsh plugins : github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
    #brew
    colorize
    colored-man-pages
    #command-not-found # warning : increase zsh load time
    docker
    #docker-compose
    fzf
    git
    golang
    #httpie
    python
    pip
    poetry
    #rust
    virtualenv
    ## external plugins
    zsh-autosuggestions     # git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    zsh-completions         # git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions"
    zsh-syntax-highlighting # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
)

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=white"

if [[ "${RUNNING_OS}" == "ubuntu" ]]; then
    plugins+=(ubuntu)
elif [[ "${RUNNING_OS}" == "debian" ]]; then
    plugins+=(debian)
fi
