# shellcheck shell=bash disable=SC1090,SC1091,SC2262,SC2263  # sourced by zsh; ls aliases are intentional
# Keep PATH/path free of duplicates automatically (zsh ties path <-> PATH)
typeset -U path PATH

# Use en_US.UTF-8 only if it's actually generated (minimal Ubuntu often lacks it),
# otherwise fall back to C.UTF-8 to avoid setlocale warnings.
if locale -a 2>/dev/null | grep -qiE '^en_US\.utf-?8$'; then
    export LANG=en_US.UTF-8
else
    export LANG=C.UTF-8
fi
# Colored man pages come from the colored-man-pages plugin; keep less from
# leaving scrollback garbage (no -X).
export MANPAGER='less'
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
# create the XDG dirs we rely on (mkdir -p makes parents, so .local etc. covered)
for d in "${XDG_CONFIG_HOME}"/{inetutils,zsh} "${XDG_CACHE_HOME}/zsh" \
         "${XDG_DATA_HOME}" "${XDG_STATE_HOME}/zsh"; do
    [[ -d "$d" ]] || mkdir -p "$d"
done

export HISTFILE="${XDG_STATE_HOME}/zsh/history"
export NETRC="${XDG_CONFIG_HOME}/inetutils/netrc"
export SCREENRC="${XDG_CONFIG_HOME}/screen/screenrc"
export WGETRC="${XDG_CONFIG_HOME}/wgetrc"

export IDE="zed"
export EDITOR="zed --wait"
export VISUAL="$EDITOR"

# base bin dirs (typeset -U keeps these unique / correctly ordered)
path+=(/usr/local/bin /usr/local/sbin "${HOME}/.local/bin" "${HOME}/bin")
unalias ll 2>/dev/null || true  # was removing oh-my-zsh's default ll alias

if [[ "$OSTYPE" == "darwin"* ]]; then
    # Set HOMEBREW_PREFIX/PATH/MANPATH correctly for either arch (Apple Silicon
    # /opt/homebrew or Intel /usr/local) without hardcoding.
    if command -v brew >/dev/null; then
        eval "$(brew shellenv)"
    elif [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    export RUBY_BIN="${HOMEBREW_PREFIX:-/usr/local}/opt/ruby/bin"
    export HOMEBREW_NO_AUTO_UPDATE=1
    # ls colors (mirrors oh-my-zsh): BSD ls via -G, palette from LSCOLORS
    export LSCOLORS="Gxfxcxdxbxegedabagacad"
    ls -G -d . &>/dev/null && alias ls='ls -G'
elif [ "$(uname)" = "Linux" ]; then
    export RUBY_BIN=/usr/bin
    # ls colors (mirrors oh-my-zsh): seed LS_COLORS, then GNU ls via --color
    [ -z "$LS_COLORS" ] && command -v dircolors >/dev/null && eval "$(dircolors -b)"
    ls --color -d . &>/dev/null && alias ls='ls --color=tty'
fi

# remove '-' from the default WORDCHARS
# in order for word-splitting to work correctly
# when deleting a word
WORDCHARS=${WORDCHARS//-/}
