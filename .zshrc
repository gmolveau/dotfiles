# uncomment next line to enable profiling
# zmodload zsh/zprof 

export ZSH=${HOME}/.oh-my-zsh
source "${HOME}/.zsh/user.sh"
source "${HOME}/.zsh/plugins.sh"
[ -f "${HOME}/.zsh/custom.sh" ] && source "${HOME}/.zsh/custom.sh"
source "${HOME}/.zsh/options.sh"
source "${ZSH}/oh-my-zsh.sh"
source "${HOME}/.zsh/exports.sh"
source "${HOME}/.zsh/aliases.sh"
source "${HOME}/.zsh/functions.sh"
source "${HOME}/.zsh/os.sh"
source "${HOME}/.zsh/macos.sh"
source "${HOME}/.zsh/linux.sh"
source "${HOME}/.zsh/nextcloud.sh"
source "${HOME}/.zsh/archive.sh"
source "${HOME}/.zsh/python.sh"
source "${HOME}/.zsh/rust.sh"
source "${HOME}/.zsh/go.sh"
source "${HOME}/.zsh/node.sh"
source "${HOME}/.zsh/sqlite.sh"
source "${HOME}/.zsh/vscode.sh"
source "${HOME}/.zsh/sublime.sh"
source "${HOME}/.zsh/ruby.sh"
[ -f "${HOME}/.zsh/work.sh" ] && source "${HOME}/.zsh/work.sh"
compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"

# uncomment next line to enable profiling
# zprof 
