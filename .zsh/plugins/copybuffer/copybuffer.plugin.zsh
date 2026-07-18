# copy the active line from the command line buffer
# onto the system clipboard

# minimal clipboard helper (replaces Oh My Zsh's clipcopy)
_copybuffer_clipcopy() {
  if command -v pbcopy &>/dev/null; then
    pbcopy                       # macOS
  elif command -v wl-copy &>/dev/null; then
    wl-copy                      # Wayland
  elif command -v xclip &>/dev/null; then
    xclip -selection clipboard   # X11
  elif command -v xsel &>/dev/null; then
    xsel --clipboard --input     # X11
  else
    return 1
  fi
}

copybuffer () {
  if printf "%s" "$BUFFER" | _copybuffer_clipcopy 2>/dev/null; then
    :
  else
    zle -M "copybuffer: no clipboard tool found (pbcopy/wl-copy/xclip/xsel)."
  fi
}

zle -N copybuffer

bindkey -M emacs "^O" copybuffer
bindkey -M viins "^O" copybuffer
bindkey -M vicmd "^O" copybuffer
