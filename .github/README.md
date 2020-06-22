# My dotfiles

## Getting started

```sh
# init the repo
git init --bare ${HOME}/.dotfiles
# ignore everything so you don't accidentally commit things
echo "*" >> ${HOME}/.dotfiles/info/exclude
# add the alias to your .bashrc or .zshrc
alias dotfiles='/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}'
# you can now use the alias
dotfiles config --local status.showUntrackedFiles no
dotfiles remote add origin git@github.com:YOUR_USERNAME/dotfiles.git
# add the files you want (-f to force add as we exclude everything)
dotfiles add -f .zshrc
dotfiles commit -m "add zshrc"
dotfiles push -u origin master
```

## Install on a new machine

```sh
# clone the repo
git clone --bare https://github.com/gmolveau/dotfiles.git ${HOME}/.dotfiles
# ignore everything so you don't accidentally commit things
echo "*" >> ${HOME}/.dotfiles/info/exclude
# add the alias to your .bashrc or .zshrc
alias dotfiles='/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}'
# you can now use the alias
dotfiles config --local status.showUntrackedFiles no
# when you're ready, clone all the files in your $HOME (use -f if you want to override your current files)
dotfiles checkout
```
