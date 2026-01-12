mkdir -p "${XDG_DATA_HOME}/python"
export PYTHONHISTFILE=${XDG_DATA_HOME}/python/history
# use UTF-8 for stdin,stdout,stderr
export PYTHONIOENCODING='UTF-8'

export PIP_BIN=${HOME}/.local/bin
if [[ ! ":${PATH}:" == *":${PIP_BIN}:"* ]]; then
    export PATH=${PIP_BIN}:${PATH}
fi
