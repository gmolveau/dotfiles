mkdir -p "${XDG_DATA_HOME}/python"
export PYTHONHISTFILE=${XDG_DATA_HOME}/python/history
# use UTF-8 for stdin,stdout,stderr
export PYTHONIOENCODING='UTF-8'

export PIP_BIN=${HOME}/.local/bin
export PATH=${PATH}:${PIP_BIN}
