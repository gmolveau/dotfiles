# shellcheck shell=bash disable=SC1090,SC1091  # sourced by zsh; closest target shellcheck supports
source "${ZSH_ROOT}/lib/compat.zsh"
source "${ZSH_ROOT}/plugins/better-virtualenv/better-virtualenv.plugin.zsh"
source "${ZSH_ROOT}/plugins/colored-man-pages/colored-man-pages.plugin.zsh"
source "${ZSH_ROOT}/plugins/copybuffer/copybuffer.plugin.zsh"
if [[ "$OSTYPE" == darwin* ]]; then
  source "${ZSH_ROOT}/plugins/macos/macos.plugin.zsh"
  source ~/.orbstack/shell/init.zsh 2>/dev/null || :
fi
source "${ZSH_ROOT}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
# syntax-highlighting MUST be sourced last
source "${ZSH_ROOT}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Update the git-backed plugins under ~/.zsh/plugins
zsh-plugins-update() {
  for d in ~/.zsh/plugins/*/; do
    [ -d "${d}.git" ] || continue
    echo "== $(basename "$d") =="
    git -C "$d" pull --ff-only
  done
}
