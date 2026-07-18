function tmp() {
    cd "$(mktemp -d "${TMPDIR:-/tmp}/${1:-}_XXXX")" || return
}
