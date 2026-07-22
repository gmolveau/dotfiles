# uncomment next line (and `zprof` at the very bottom) to profile startup
# zmodload zsh/zprof

ZSH_ROOT="${HOME}/.zsh"

# --- prompt requirements ---
autoload -U colors && colors
setopt PROMPT_SUBST

# --- config modules ---
source "${ZSH_ROOT}/user.sh"
[ -f "${ZSH_ROOT}/custom.sh" ] && source "${ZSH_ROOT}/custom.sh"
source "${ZSH_ROOT}/options.sh"
source "${ZSH_ROOT}/lib/spectrum.zsh"
source "${ZSH_ROOT}/lib/git-prompt.zsh"
source "${ZSH_ROOT}/exports.sh"
source "${ZSH_ROOT}/mise.sh"
source "${ZSH_ROOT}/fzf.sh"
source "${ZSH_ROOT}/nextcloud.sh"
source "${ZSH_ROOT}/archive.sh"
source "${ZSH_ROOT}/python.sh"
source "${ZSH_ROOT}/rust.sh"
source "${ZSH_ROOT}/go.sh"
source "${ZSH_ROOT}/node.sh"
source "${ZSH_ROOT}/sqlite.sh"
source "${ZSH_ROOT}/php.sh"
source "${ZSH_ROOT}/ruby.sh"
[ -f "${ZSH_ROOT}/work.sh" ] && source "${ZSH_ROOT}/work.sh"
source "${ZSH_ROOT}/gregouz.zsh-theme"

# --- completions: fpath + compinit + zsh-completions-update ---
source "${ZSH_ROOT}/completions.sh"

# --- plugins (after completions) ---
source "${ZSH_ROOT}/plugins.sh"

# uncomment to profile startup (see top of file)
# zprof
