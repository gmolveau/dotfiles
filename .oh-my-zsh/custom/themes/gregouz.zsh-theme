# always use single quote for PROMPT and RPROMPT
# PROMPT = '' on the left
# RPROMPT = '' on the right
# see every numeric color : for code in {000..255}; do print -P -- "$code: %F{$code}Color%f"; done
# text colors : %F{cyan}text%f
# background color : %K{white}%k
# unicode caracter (eg. star) : \u2b50
# Reset both text and background color: %{$reset_color%}
# exit code : %(?.ok.%F{red}nok%f)
# standout : %Stext%s
# bold : %Btext%b
# underlined : %Utext%u
# two lines arrow : '╭text\n╰→'
# username : %n
# hostname : %m
# current directory : %1/
# full path : %//
# current time in 24-hour format with seconds : %*
# supercharge git prompt :
#   ZSH_THEME_GIT_PROMPT_PREFIX="<"
#   ZSH_THEME_GIT_PROMPT_SUFFIX=">"
#   ZSH_THEME_GIT_PROMPT_DIRTY="*"
#   ZSH_THEME_GIT_PROMPT_CLEAN=""
# then call : $(git_prompt_info)
# virtualenv :
#   ZSH_THEME_VIRTUALENV_PREFIX="("
#   ZSH_THEME_VIRTUALENV_SUFFIX=")"
# the call : $(virtualenv_info)
# see variable using : print -P 'VAR' (eg. print -P %~)

# resources :
# - https://blog.carbonfive.com/writing-zsh-themes-a-quickref/ (https://web.archive.org/web/20210615140317/https://blog.carbonfive.com/writing-zsh-themes-a-quickref/)

function virtualenv_info {
    [ "$VIRTUAL_ENV" ] && echo " ($(basename "$VIRTUAL_ENV")) "
}

function kubernetes_info {
    if typeset -f kube_ps1 > /dev/null; then
        KUBE_PS1_PREFIX=" k8s:("
        KUBE_PS1_SUFFIX=")"
        KUBE_PS1_SYMBOL_ENABLE="false"
        kube_ps1
    fi
}

ZSH_THEME_GIT_PROMPT_PREFIX=" %F{cyan}git:"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[214]!%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_VIRTUALENV_PREFIX=" ("
ZSH_THEME_VIRTUALENV_SUFFIX=")"

PROMPT='$FG[119]%n@%m%f:%{$terminfo[bold]$fg[blue]%}%//%{$reset_color%}$(git_prompt_info)$(virtualenv_info)$(kubernetes_info)
%(?.%F{green}.%F{red})%(!.#.❯)%f $ '

RPROMPT='$FG[248][%*]%f'