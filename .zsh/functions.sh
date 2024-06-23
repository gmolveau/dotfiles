function cdf() {
    # cd to the parent directory of a file, useful when drag-dropping a file into the terminal
    if [ -f "${1}" ]; then
        cd "$(dirname "${1}")" || return 1
    else
        cd "${1}" || return 1
    fi
    pwd
}
alias fcd="cdf"

# create a new directory and enter it - mkdir + cd
function mkcd() {
    mkdir -p "$@" && cd "$_" || return 1
}

# create a random folder in /tmp and cd into it
function tmp {
    cd "$(mktemp -d /tmp/"${1:-}"_XXXX)" || return 1
}
