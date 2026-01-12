alias cp="cp -iv"
alias dotfiles='/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}'
alias ffind="sk --ansi -i -c 'ag --color \"{}\"' --bind 'ctrl-p:execute-silent(subl {1})+accept,ctrl-y:execute(preview.sh {}),command-c:execute(echo {} | pbcopy)'"
alias know='${IDE} ${HOME}/dev/knowledge/content/docs'
alias ln="ln -v"
alias mv="mv -iv"
alias notes='${IDE} ${HOME}/Nextcloud/Notes'
alias ooo="open ."
alias path='echo $PATH | tr : "\n" | uniq'
alias reload='exec ${SHELL} -l'
alias s="subl"
alias shrug='echo -E "¯\_(ツ)_/¯" | tee /dev/tty | pbcopy'
alias sss="subl ."
alias wget='wget --hsts-file ${XDG_DATA_HOME}/wget/wget_hsts'
alias zshconfig='${IDE} ~/.zshrc'
