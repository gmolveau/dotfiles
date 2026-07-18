export PHP_BIN="${XDG_CONFIG_HOME}/herd-lite/bin"
path+=("${PHP_BIN}")
export PHP_INI_SCAN_DIR="${PHP_BIN}:${PHP_INI_SCAN_DIR}"
