export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'
mkdir -p "${HOME}"/{.config,.cache,.local}
export XDG_CONFIG_HOME=${HOME}/.config
mkdir -p "${XDG_CONFIG_HOME}"/{inetutils,zsh}
export XDG_CACHE_HOME=${HOME}/.cache
mkdir -p "${XDG_CACHE_HOME}/zsh"
export XDG_DATA_HOME=${HOME}/.local/share
mkdir -p "${XDG_DATA_HOME}"
export XDG_STATE_HOME=${HOME}/.local/state
mkdir -p "${XDG_STATE_HOME}/zsh"
export HISTFILE="${XDG_STATE_HOME}/zsh/history"
export NETRC=${XDG_CONFIG_HOME}/inetutils/netrc
export SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
export OLD_PATH=${PATH}
export USER_BIN=/usr/local/bin:/usr/local/sbin:${HOME}/bin
export PATH=${PATH}:${USER_BIN}

if [[ "$OSTYPE" == "darwin"* ]]; then
    export PIP_BIN="${HOME}/Library/Python/3.10/bin:${HOME}/Library/Python/3.11/bin"
    export RUBY_BIN=/usr/local/opt/ruby/bin
    export OPENJDK_BIN=/usr/local/opt/openjdk/bin
    export HOMEBREW_NO_AUTO_UPDATE=1
elif [ "$(uname)" = "Linux" ]; then
    export RUBY_BIN=/usr/bin
    export OPENJDK_BIN=
fi
