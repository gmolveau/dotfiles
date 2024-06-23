OS=$(uname)
if [ "$OS" = "Linux" ]; then
    DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    if [[ "${DISTRIB}" = "Ubuntu"* ]]; then
        export OS="ubuntu"
    elif [[ "${DISTRIB}" = "Debian"* ]]; then
        export OS="debian"
    fi
elif [ "$OS" = "Darwin" ]; then
    export OS="macos"
fi
