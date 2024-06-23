export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'
mkdir -p "${HOME}"/{.config,.cache,.local}
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share
mkdir -p "${XDG_CONFIG_HOME}"/{inetutils,zsh}
export NETRC=${XDG_CONFIG_HOME}/inetutils/netrc
export HISTFILE=${XDG_CONFIG_HOME}/zsh/zsh_history
export OLD_PATH=${PATH}
export USER_BIN=/usr/local/bin:/usr/local/sbin:${HOME}/bin
export PATH=${PATH}:${USER_BIN}
