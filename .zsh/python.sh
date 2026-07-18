export PIP_HOME="${XDG_DATA_HOME}/python"
export PIP_BIN=${PIP_HOME}/bin
mkdir -p "${PIP_BIN}"

path+=("${PIP_BIN}")

export PYTHONHISTFILE=${XDG_DATA_HOME}/python/history
# use UTF-8 for stdin,stdout,stderr
export PYTHONIOENCODING='UTF-8'
