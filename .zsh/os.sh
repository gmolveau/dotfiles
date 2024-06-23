if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    if [[ "${DISTRIB}" = "Ubuntu"* ]]; then
        export RUNNING_OS="ubuntu"
    elif [[ "${DISTRIB}" = "Debian"* ]]; then
        export RUNNING_OS="debian"
    fi
elif [[ "$OSTYPE" == "darwin"* ]]; then
    export RUNNING_OS="macos"
fi
