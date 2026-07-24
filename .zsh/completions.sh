# shellcheck shell=bash disable=SC1090,SC1091  # sourced by zsh; closest target shellcheck supports

# --- extend fpath BEFORE compinit ---
fpath=(
  "${ZSH_ROOT}/completions"
  "${ZSH_ROOT}/plugins/zsh-completions/src"
  "${fpath[@]}"
)
if [[ -d "${HOMEBREW_PREFIX}/share/zsh/site-functions" ]]; then
  fpath=("${HOMEBREW_PREFIX}/share/zsh/site-functions" "${fpath[@]}")
fi

autoload -Uz compinit
_zcompdump="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump"
if [[ ! -f "${_zcompdump}" ]] || [[ -n $(find "${_zcompdump}" -mtime +1 2>/dev/null) ]]; then
  compinit -d "${_zcompdump}"
else
  compinit -C -d "${_zcompdump}"
fi
# Compile the dump to wordcode when stale; backgrounded+disowned so it never blocks startup
if [[ ! -f "${_zcompdump}.zwc" || "${_zcompdump}" -nt "${_zcompdump}.zwc" ]]; then
  zcompile "${_zcompdump}" &!
fi
zstyle ':completion:*' menu select

# SSH host completion from ~/.ssh/config
_ssh_configfile="$HOME/.ssh/config"
if [[ -f "$_ssh_configfile" ]]; then
  _ssh_hosts=(${(f)"$(grep -E '^Host\s' "$_ssh_configfile" | awk '{for (i=2; i<=NF; i++) print $i}' | sort -u | grep -v '^*' | sed -e 's/\.*\*$//')"})
  zstyle ':completion:*:hosts' hosts "$_ssh_hosts[@]"
  unset _ssh_hosts
fi
unset _ssh_configfile

# Regenerate tool completions into ~/.zsh/completions/ from the installed tools.
# _cargo stays committed (it's a shim that tracks the toolchain); the rest are
# generated snapshots we deliberately do not commit.
zsh-completions-update() {
  local dir="${HOME}/.zsh/completions"
  mkdir -p "$dir"
  command -v uv >/dev/null && uv generate-shell-completion zsh > "$dir/_uv"
  command -v rustup  >/dev/null && rustup completions zsh > "$dir/_rustup"
  command -v gh >/dev/null && gh completion -s zsh > "$dir/_gh"
  command -v kubectl >/dev/null && kubectl completion zsh > "$dir/_kubectl"
  command -v docker >/dev/null && docker completion zsh > "$dir/_docker"
  command -v just >/dev/null && just --completions zsh > "$dir/_just"
  rm -f "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump" # force compinit rebuild
  print "completions regenerated in ${dir}"
}
