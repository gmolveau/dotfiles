# ohmyzsh plugins : https://github.com/ohmyzsh/ohmyzsh/wiki/plugins
plugins=(
    colorize
    colored-man-pages
    copybuffer
    copyfile
    copypath
    #command-not-found # warning : increase zsh load time
    docker
    #docker-compose
    fzf
    git
    git-auto-fetch
    golang
    #httpie
    python
    pip
    rust
    ssh
    uv
    virtualenv
    ## external plugins
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

OS=$(uname)
if [ "$OS" = "Linux" ]; then
    DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    if [[ "${DISTRIB}" = "Ubuntu"* ]]; then
        plugins+=(ubuntu)
    elif [[ "${DISTRIB}" = "Debian"* ]]; then
        plugins+=(debian)
    fi
elif [ "$OS" = "Darwin" ]; then
    plugins+=(brew)
    plugins+=(macos)
fi
