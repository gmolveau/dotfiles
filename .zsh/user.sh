function tmp() {
    cd "$(mktemp -d "${TMPDIR:-/tmp}/${1:-}_XXXX")" || return
}

# make a directory (and parents) then cd into it
function mkcd() {
    mkdir -p "$@" && cd "${@:$#}" || return
}
