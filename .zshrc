#-- OH MY ZSH --#
#--- INSTALL ---#
#---- online ----#
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#---- offline / airgapped ----#
# git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
# cp ~/.zshrc ~/.zshrc.bck
# cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# chsh -s $(which zsh)
# DISABLE_AUTO_UPDATE=true

# zmodload zsh/zprof # uncomment for profiling
# # measure with : for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done

export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="gregouz"

plugins=(
    ## internal plugins : github.com/ohmyzsh/ohmyzsh/tree/master/plugins
    #brew
    colorize
    colored-man-pages
    #command-not-found # warning : increase zsh load time
    docker
    #docker-compose
    fzf
    git
    golang
    #httpie
    python
    pip
    poetry
    #rust
    virtualenv
    ## external plugins
    zsh-autosuggestions     # git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
    zsh-completions         # git clone https://github.com/zsh-users/zsh-completions "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-completions"
    zsh-syntax-highlighting # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
)

if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    local DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    if [[ "${DISTRIB}" = "Ubuntu"* ]]; then
        plugins+=(ubuntu)
        skip_global_compinit=1
    elif [[ "${DISTRIB}" = "Debian"* ]]; then
        plugins+=(debian)
    fi
fi

#-- MACOS SPECIFICS --#
if [[ "$OSTYPE" == "darwin"* ]]; then
    # curl -L https://iterm2.com/shell_integration/zsh -o ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/iterm2_shell_integration.zsh
    [ -f "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/iterm2_shell_integration.zsh" ] && source "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/iterm2_shell_integration.zsh"
    # Specify the preferences directory
    defaults write com.googlecode.iterm2 "PrefsCustomFolder" -string "~/.config/iterm2/config"
    # Tell iTerm2 to use the custom preferences in the directory
    defaults write com.googlecode.iterm2 "LoadPrefsFromCustomFolder" -bool true
fi

#-- OPTIONS --#
DISABLE_UPDATE_PROMPT=true # automatically update ohmyzsh
REPORTTIME=10              # Print duration of command if it took more than 10 seconds
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=10000000
SAVEHIST=10000000
setopt EXTENDED_HISTORY     # Write the history file in the ':start:elapsed;command' format.
setopt INC_APPEND_HISTORY   # Write to the history file immediately, not when the shell exits.
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE    # Do not record an event starting with a space.
setopt HIST_VERIFY          # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY       # append to history file (Default)
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks from each command line being added to the history.

source ${ZSH}/oh-my-zsh.sh

#-- SUBLIME TEXT --#
# # windows = sudo ln -s /mnt/c/Program\ Files/Sublime\ Text\ 3/subl.exe /usr/bin/subl
# # macOS = ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/subl

source "${HOME}/.rye/env"

#-- EXPORTS --#
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then # linux
    export PIP_BIN=${HOME}/.local/bin
    export RUBY_BIN=/usr/bin
    export OPENJDK_BIN=
elif [[ "${OSTYPE}" == "darwin"* ]]; then # macOS
    export PIP_BIN="${HOME}/Library/Python/3.10/bin:${HOME}/Library/Python/3.11/bin"
    export RUBY_BIN=/usr/local/opt/ruby/bin
    export OPENJDK_BIN=/usr/local/opt/openjdk/bin
fi
export IDE='subl'
export EDITOR='subl -w'
export LANG='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'
export MANPAGER='less -X' # Don’t clear the screen after quitting a manual page.
mkdir -p ${HOME}/{.config,.cache,.local}
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache
export XDG_DATA_HOME=${HOME}/.local/share
# XDG_CACHE_HOME
mkdir -p ${XDG_CACHE_HOME}/{npm}
# XDG_CONFIG_HOME
mkdir -p ${XDG_CONFIG_HOME}/{inetutils,zsh}
export NETRC=${XDG_CONFIG_HOME}/inetutils/netrc
export HISTFILE=${XDG_CONFIG_HOME}/zsh/zsh_history
# XDG_DATA_HOME
mkdir -p ${XDG_DATA_HOME}/{cargo,deno,python,sqlite}
export CARGO_HOME=${XDG_DATA_HOME}/cargo
export DENO_DIR=${XDG_DATA_HOME}/deno
export PYTHONHISTFILE=${XDG_DATA_HOME}/python/history
export SQLITE_HISTORY=${XDG_DATA_HOME}/sqlite/history
# PYTHON
export PYTHONIOENCODING='UTF-8' # use UTF-8 for stdin,stdout,stderr
# BINARIES
export CARGO_BIN=${CARGO_HOME}/bin
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export NODE_BIN=${HOME}/.local/bin
export PIP_BIN=${HOME}/.local/bin
export USER_BIN=/usr/local/bin:/usr/local/sbin:${HOME}/bin
export OLD_PATH=${PATH}
export PATH=${PATH}:${GOBIN}:${CARGO_BIN}:${PIP_BIN}:${NODE_BIN}:${RUBY_BIN}:${LLVM_BIN}:${OPENJDK_BIN}:${USER_BIN}
# FOLDERS
export NEXTCLOUD=${HOME}/Nextcloud
export ARCHIVE=${NEXTCLOUD}/Documents/archive

#-- ALIASES --#
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
    alias open="xdg-open"
    alias pbcopy="xclip -selection clipboard"
    alias ll="ls -alh"
    if grep -qi microsoft /proc/version 2> /dev/null; then # Microsoft WSL2
        alias open="explorer.exe"
        alias pbcopy="clip.exe"
    fi
elif [[ "${OSTYPE}" == "darwin"* ]]; then
    alias delete_ds_store="find . -name '.DS_Store' -type f -delete"
    alias ll="ls -1AbGhTvl"
fi

alias backup='cp $1 ${1}.bck'
alias cp="cp -iv"
alias dotfiles='/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}'
alias ffind="sk --ansi -i -c 'ag --color \"{}\"' --bind 'ctrl-p:execute-silent(subl {1})+accept,ctrl-y:execute(preview.sh {}),command-c:execute(echo {} | pbcopy)'"
alias know="${IDE} ${HOME}/dev/knowledge/content/docs"
alias ln="ln -v"
alias mv="mv -iv"
alias notes="${IDE} ${HOME}/Nextcloud/Notes"
alias ooo="open ."
alias path='echo -e ${PATH//:/\\n}'
alias reload="exec ${SHELL} -l"
alias s="subl"
alias sss="subl ."
alias ccc="code ."
alias shrug='echo -E "¯\_(ツ)_/¯" | tee /dev/tty | pbcopy'
alias wget="wget --hsts-file ${XDG_DATA_HOME}/wget/wget_hsts"
alias zshconfig="${IDE} ~/.zshrc"

#-- FUNCTIONS --#
# cd to the parent directory of a file, useful when drag-dropping a file into the terminal
function cdf() {
    [ -f "${1}" ] && { cd "$(dirname "${1}")"; } || { cd "${1}"; }
    pwd
}
alias fcd="cdf"

# create a new directory and enter it - mkdir + cd
function mkcd() {
    mkdir -p "$@" && cd "$_"
}

# create a random folder in /tmp and cd into it
function tmp {
    cd $(mktemp -d /tmp/${1}_XXXX)
}

#-- PERSONAL ARCHIVE --#
# TODO en faire un cli
function archive-download() {
    if [ $# -eq 0 ]; then
        echo "missing argument: URL"
        exit 1
    fi
    FILE=$(wget -P ${ARCHIVE} -nv --content-disposition "${1}" 2>&1 | cut -d\" -f2)
    FILENAME="$(basename -- "${1}")"
    EXTENSION=$([[ "${FILENAME}" = *.* ]] && echo ".${FILENAME##*.}" || echo '')
    if [ $# -eq 2 ]; then
        FILENAME="$(date +%Y-%m-%d)-$(echo "${2}" | sed -E 's/[^[:alnum:]]+/_/g')"
    fi
    mv -n ${FILE} ${ARCHIVE}/${FILENAME}${EXTENSION}
    echo ${ARCHIVE}/${FILENAME}${EXTENSION}
}

function archive-youtube() {
    youtube-dl -no-playlist --embed-subs --write-auto-sub -no-playlist --merge-output-format mkv --restrict-filenames -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' -o '${ARCHIVE}/'$(date +%Y-%m-%d)'-%(title)s.%(ext)s' "${1}"
}

function archive-web() {
    if [ $# -eq 2 ]; then
        FILENAME="$(date +%Y-%m-%d)-$(echo "${2}" | sed -E 's/[^[:alnum:]]+/_/g').html"
    elif [ $# -eq 1 ]; then
        FILENAME="$(date +%Y-%m-%d)-$(basename "${1}" | sed -E 's/[^[:alnum:]]+/_/g').html"
    elif [ $# -eq 0 ]; then
        echo "missing argument: URL"
        exit 1
    fi
    # brew install monolith | snap install monolith
    monolith -f -j -s ${1} -o ${ARCHIVE}/${FILENAME}
    echo ${FILENAME}
}

# OS-specifics functions
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then # linux

    function update() {
        deactivate 2> /dev/null
        sudo apt update && sudo apt -y upgrade && sudo apt -y dist-upgrade
        echo "updating npm ..."
        sudo npm install -g npm
        npm update -g
        echo "updating gem ..."
        gem update
        echo "updating cargo ..."
        cargo update
        echo "updating pip and pip apps ..."
        pip3 install --user --upgrade pip
        command -v pip-chill > /dev/null 2>&1 || pip3 install --user pip-chill
        pip-chill --no-version | xargs pip3 install -U
    }

    function freeze() {
        println "# apt-get packages"
        python3 -c "from apt import cache;manual = set(pkg for pkg in cache.Cache() if pkg.is_installed and not pkg.is_auto_installed);depends = set(dep_pkg.name for pkg in manual for dep in pkg.installed.get_dependencies('PreDepends', 'Depends', 'Recommends') for dep_pkg in dep);print('\n'.join(pkg.name for pkg in manual if pkg.name not in depends))"
        println "# snap packages"
        snap list | grep -v Publisher | grep -v canonical | awk '{print $1}'
        if [ -d "$HOME/bin" ]; then
            println "# user bin "
            ls -1 "$HOME/bin"
        fi
        println "# pip3 apps"
        pip-chill --no-version
        println "# golang apps "
        ls -1 ${GOBIN}
        println "# cargo apps "
        cargo install --list
        echo "# npm apps \n"
        npm list -g --depth=0
    }

elif [[ "${OSTYPE}" == "darwin"* ]]; then # macOS

    function update() {
        deactivate 2> /dev/null
        println "updating brew ..."
        brew update
        println "upgrading brew ..."
        brew upgrade
        println "cleaning brew ..."
        brew cleanup -s
        #now diagnotic
        brew doctor
        brew missing

        println "updating app store apps ..."
        mas upgrade
    }

    function freeze() {
        println "# /Applications"
        ls -1 /Applications
        println "# ~/Applications"
        ls -1 ~/Applications
        println "# Mac App Store apps"
        mas list | sed 's/ / # /'
        println "# brew apps"
        brew leaves
        println "# pip3 apps"
        command -v pip-chill > /dev/null 2>&1 || pip3 install pip-chill
        pip-chill --no-version
        println "# golang apps"
        ls -1 ${GOBIN}
        println "# cargo apps"
        cargo install --list
        println "# npm apps"
        npm list -g --depth=0
    }
fi

#zprof # uncomment for profiling
