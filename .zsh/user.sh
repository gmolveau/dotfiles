ZSH_THEME="gregouz"

function tmp() {
    cd "$(mktemp -d /tmp/"${1:-}"_XXXX)" || return
}
