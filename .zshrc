#-- OH MY ZSH --#

# zmodload zsh/zprof # uncomment for profiling
# for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done # uncomment for profiling

## Install
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# --- or offline install via :
# git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh
# cp ~/.zshrc ~/.zshrc.bck
# cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
# chsh -s $(which zsh)

export ZSH=${HOME}/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
  ## internal plugins : github.com/ohmyzsh/ohmyzsh/tree/master/plugins
  #cargo
  colorize
  colored-man-pages
  #command-not-found # warning : increase zsh load time
  docker
  #docker-compose
  git
  golang
  #httpie
  python
  pip
  #rust
  virtualenv
  ## external plugins
  # git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  zsh-autosuggestions
  # git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions
  zsh-completions
  # git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  zsh-syntax-highlighting
)
## OS Specifics
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
  local DISTRIB=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
  if [[ "${DISTRIB}" = "Ubuntu"* ]]; then
    plugins+=(ubuntu)
    skip_global_compinit=1
  elif [[ "${DISTRIB}" = "Debian"* ]]; then
    plugins+=(debian)
  fi
elif [[ "${OSTYPE}" == "darwin"* ]]; then
  plugins+=(osx)
fi
## finally
source ${ZSH}/oh-my-zsh.sh

#-- MACOS SPECIFICS --#
if [[ "$OSTYPE" == "darwin"* ]]; then
  # curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
fi

autoload -U compinit && compinit

#-- OPTIONS --#
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

#-- SUBLIME TEXT --#
# macOS = ln -s "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" /usr/local/bin/sublime
# linux = ln -s /usr/bin/subl /usr/bin/sublime

#-- EXPORTS --#
# OS Specifics
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then # linux
  export NODE_BIN=/usr/local/opt/node@10/bin
  export PIP_BIN=
  export RUBY_BIN=/usr/bin
  export OPENJDK_BIN=
elif [[ "${OSTYPE}" == "darwin"* ]]; then # macOS
  export LDFLAGS="-L/usr/local/opt/llvm/lib -Wl,-rpath,/usr/local/opt/llvm/lib"
  export CPPFLAGS="-I/usr/local/opt/llvm/include"
  export LLVM_BIN="/usr/local/opt/llvm/bin"
  export CC="/usr/local/opt/llvm/bin/clang"
  export CXX="${CC}++"
  export NODE_BIN=/usr/local/opt/node@10/bin
  export PIP_BIN=${HOME}/Library/Python/3.9/bin
  export RUBY_BIN=/usr/local/opt/ruby/bin
  export OPENJDK_BIN=/usr/local/opt/openjdk/bin
fi
# ZSH
export EDITOR='sublime -w'
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
export USER_BIN=/usr/local/bin:/usr/local/sbin:${HOME}/.local/bin:${HOME}/bin
export GOPATH=${HOME}/go
export GOBIN=${GOPATH}/bin
export CARGO_BIN=${CARGO_HOME}/bin
export OLD_PATH=${PATH}
export PATH=${GOBIN}:${CARGO_BIN}:${PIP_BIN}:${NODE_BIN}:${RUBY_BIN}:${LLVM_BIN}:${OPENJDK_BIN}:${USER_BIN}:${PATH}
# FOLDERS
export ARCHIVE=${HOME}/Nextcloud/Documents/archive
export NEXTCLOUD=${HOME}/Nextcloud

#-- ALIASES --#
# OS Specifics
if [[ "${OSTYPE}" == "linux-gnu"* ]]; then
  if grep -qi microsoft /proc/version 2> /dev/null; then # Microsoft WSL2
    alias open="explorer.exe"
    alias pbcopy="clip.exe"
  else
    alias open="xdg-open"
    alias pbcopy="xclip -selection clipboard"
  fi
elif [[ "${OSTYPE}" == "darwin"* ]]; then
  #
fi

alias cp="cp -iv"
alias delete_ds_store="find . -name '.DS_Store' -type f -delete"
alias dotfiles='/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}'
alias ffind="sk --ansi -i -c 'ag --color \"{}\"' --bind 'ctrl-p:execute-silent(sublime {1})+accept,ctrl-y:execute(preview.sh {}),command-c:execute(echo {} | pbcopy)'"
alias know="sublime ${HOME}/dev/knowledge/content/docs"
alias ll="ls -alh"
alias ln="ln -v"
alias mv="mv -iv"
alias myip="dig +short myip.opendns.com @resolver1.opendns.com"
alias notes="sublime ${HOME}/Nextcloud/Notes"
alias ooo="open ."
alias path='echo -e ${PATH//:/\\n}'
alias reload="exec ${SHELL} -l"
alias s="sublime"
alias sss="sublime ."
alias standup="( cd ~/dev && git standup -m 2 -s -A 'last Monday' -D format:'%A ùd %B %Y - %H:%M' )"
alias shrug='echo -E "¯\_(ツ)_/¯" | tee /dev/tty | pbcopy'
alias todo="sublime ${NEXTCLOUD}/Notes/_TODO.txt"
alias wget="wget --hsts-file ${XDG_DATA_HOME}/wget/wget_hsts"
alias xargs='xargs ' # create an xargs alias with trailing space
alias zshconfig="sublime ~/.zshrc"

#-- FUNCTIONS --#

# cd to the parent directory of a file, useful when drag-dropping a file into the terminal
function cdf () { [ -f "${1}" ] && { cd "$(dirname "${1}")"; } || { cd "${1}"; } ; pwd; }
alias fcd="cdf"

# johnnydecimal cd - johnnydecimal.com/concepts/working-at-the-terminal/
function cjd () {
  pushd ~/Nextcloud/Documents/*/*/${1}*
}

# copy to clipboard
function clip() {
  cat $1 | pbcopy
}

# find dirty git repos
function dirty() {
  find ~/dev -name .git -type d -prune 2> /dev/null | while read d; do (cd $d/.. ; [[ -z $(git status -s) ]] || echo "${PWD} is not clean" ); done
}

# wrapper for easy extraction of compressed files
function extract () {
  if [ -f ${1} ] ; then
      case ${1} in
          *.tar.xz)    tar xvJf ${1}    ;;
          *.tar.bz2)   tar xvjf ${1}    ;;
          *.tar.gz)    tar xvzf ${1}    ;;
          *.bz2)       bunzip2 ${1}     ;;
          *.rar)       unrar e ${1}     ;;
          *.gz)        gunzip ${1}      ;;
          *.tar)       tar xvf ${1}     ;;
          *.tbz2)      tar xvjf ${1}    ;;
          *.tgz)       tar xvzf ${1}    ;;
          *.apk)       unzip ${1}       ;;
          *.epub)      unzip ${1}       ;;
          *.xpi)       unzip ${1}       ;;
          *.zip)       unzip ${1}       ;;
          *.war)       unzip ${1}       ;;
          *.jar)       unzip ${1}       ;;
          *.Z)         uncompress ${1}  ;;
          *.7z)        7z x ${1}        ;;
          *)           echo "don't know how to extract '${1}'..." ;;
      esac
  else
      echo "'${1}' is not a valid file!"
  fi
}

# find where a text is located in current dir
function findtext() {
  grep -rnw . -e "$*"
}

# markdown bash execute : https://gist.github.com/gmolveau/67d10dfaea1fdd729865b2f8d46f7488
function mdexe() {
  if [ -f "${1}" ]; then
    cat ${1} | # print the file
    sed -n '/```bash/,/```/p' | # get the bash code blocks
    sed 's/```bash//g' | #  remove the ```bash
    sed 's/```//g' | # remove the trailing ```
    sed '/^$/d' | # remove empty lines
    ${SHELL} ; # execute the commands
  else
    echo "${1} is not valid" ;
  fi
}

# create a new directory and enter it - mkdir + cd
function mkcd () {
  mkdir -p "$@" && cd "$_";
}

function pdfcompress() {
  # source : https://gist.github.com/ahmed-musallam/27de7d7c5ac68ecbd1ed65b6b48416f9
  # brew install ghostscript | apt install ghostscript
  gs -q -dNOPAUSE -dBATCH -dSAFER -sDEVICE=pdfwrite -dCompatibilityLevel=1.3 -dPDFSETTINGS=/screen -dEmbedAllFonts=true -dSubsetFonts=true -dColorImageDownsampleType=/Bicubic -dColorImageResolution=144 -dGrayImageDownsampleType=/Bicubic -dGrayImageResolution=144 -dMonoImageDownsampleType=/Bicubic -dMonoImageResolution=144 -sOutputFile=compressed.${1} ${1};
}

function println() { echo ; echo "$@" ; echo }

function random_string() {
  env LC_CTYPE=C LC_ALL=C tr -dc "a-z0-9" < /dev/urandom | head -c 32; echo
}

# create a random folder in /tmp and cd into it
function tmp {
  cd $(mktemp -d /tmp/${1}_XXXX)
}

function youtube-mp3 () {
  youtube-dl --restrict-filenames --ignore-errors -f bestaudio --extract-audio --audio-format mp3 --audio-quality 0 -o '~/Music/%(title)s.%(ext)s' "${1}"
}

function youtube-mp4() {
  youtube-dl --restrict-filenames --embed-subs --write-auto-sub --merge-output-format mkv -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' -o '~/Movies/%(title)s.%(ext)s' "${1}"
  # --postprocessor-args "-c:v libx265 -c:a aac -strict experimental -preset slow -x265-params crf=21"
  # TODO x265 encode, audio in AAC, constant-quality RF 21, preset slow
}

#-- PERSONAL ARCHIVE --#
# TODO en faire un cli
function archive-download () {
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
  mv -n ${FILE} ${ARCHIVE}/${FILENAME}${EXTENSION};
  echo ${ARCHIVE}/${FILENAME}${EXTENSION};
}

function archive-youtube () {
  youtube-dl -no-playlist --embed-subs --write-auto-sub -no-playlist --merge-output-format mkv --restrict-filenames -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/mp4' -o '${ARCHIVE}/'$(date +%Y-%m-%d)'-%(title)s.%(ext)s' "${1}"
}

function archive-web () {
  if [ $# -eq 2 ]; then
    FILENAME="$(date +%Y-%m-%d)-$(echo "${2}" | sed -E 's/[^[:alnum:]]+/_/g').html"
  elif [ $# -eq 1 ]; then
    FILENAME="$(date +%Y-%m-%d)-$(basename "${1}" | sed -E 's/[^[:alnum:]]+/_/g').html"
  elif [ $# -eq 0 ]; then
    echo "missing argument: URL"
    exit 1
  fi
  # brew install monolith | snap install monolith
  monolith -f -j -s ${1} -o ${ARCHIVE}/${FILENAME};
  echo ${FILENAME};
}

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
    command -v pip-chill >/dev/null 2>&1 || pip3 install --user pip-chill
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

    println "updating apps from the mac app store ..."
    if brew ls --versions mas > /dev/null; then
      mas upgrade
    else
      brew install mas
      mas upgrade
    fi
    println "updating npm ..."
    npm update -g
    println "updating gem ..."
    gem update
    println "updating cargo ..."
    cargo update
    println "updating pip and pip apps ..."
    pip3 install --user --upgrade pip
    command -v pip-chill >/dev/null 2>&1 || pip3 install --user pip-chill
    pip-chill --no-version | xargs pip3 install -U
  }

  function freeze() {
    println "# System and User .app"
    ls -1 /Applications 
    ls -1 ~/Applications 
    println "# Mac App Store apps"
    mas list | sed 's/ / # /'  
    println "# brew apps"
    brew leaves 
    println "# brew cask apps"
    brew cask list | tr -s ' ' 
    println "# pip3 apps"
    command -v pip-chill >/dev/null 2>&1 || pip3 install pip-chill
    pip-chill --no-version 
    println "# golang apps"
    ls -1 ${GOBIN} 
    println "# cargo apps"
    cargo install --list 
    println "# npm apps"
    npm list -g --depth=0 
  }
fi

# zprof # uncomment for profiling