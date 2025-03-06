mkdir -p "${XDG_CACHE_HOME}"/npm
export NODE_BIN=${HOME}/.local/bin
export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
export PATH=${PATH}:${NODE_BIN}
