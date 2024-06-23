alias open="xdg-open"
alias pbcopy="xclip -selection clipboard"
alias ll="ls -alh"
# Microsoft WSL2
if grep -qi microsoft /proc/version 2> /dev/null; then
    alias open="explorer.exe"
    alias pbcopy="clip.exe"
fi
