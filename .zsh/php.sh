export PHP_BIN="${XDG_CONFIG_HOME}/herd-lite/bin"
if [[ ! ":${PATH}:" == *":${PHP_BIN}:"* ]]; then
    export PATH="${PATH}:${PHP_BIN}"
fi
export PHP_INI_SCAN_DIR="${PHP_BIN}:${PHP_INI_SCAN_DIR}"
