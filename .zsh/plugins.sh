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
    ssh
    virtualenv
    ## external plugins
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

if [[ "${OS}" == "ubuntu" ]]; then
    plugins+=(ubuntu)
elif [[ "${OS}" == "debian" ]]; then
    plugins+=(debian)
fi
