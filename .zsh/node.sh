mkdir -p "${XDG_CACHE_HOME}/npm"
mkdir -p "${XDG_CONFIG_HOME}/npm"
export NODE_HOME="${XDG_DATA_HOME}/npm"
export NODE_BIN=${NODE_HOME}/bin
mkdir -p "${NODE_BIN}"

if [[ ! ":${PATH}:" == *":${NODE_BIN}:"* ]]; then
    export PATH="${PATH}:${NODE_BIN}"
fi

export NODE_REPL_HISTORY="${XDG_STATE_HOME}/node_repl_history"
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npm/npmrc"
