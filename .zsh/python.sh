export PIP_HOME="${XDG_DATA_HOME}/python"
export PIP_BIN=${PIP_HOME}/bin
mkdir -p "${PIP_BIN}"

if [[ ! ":${PATH}:" == *":${PIP_BIN}:"* ]]; then
    export PATH="${PATH}:${PIP_BIN}"
fi

export PYTHONHISTFILE=${XDG_DATA_HOME}/python/history
# use UTF-8 for stdin,stdout,stderr
export PYTHONIOENCODING='UTF-8'
