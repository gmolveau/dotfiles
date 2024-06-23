# My dotfiles

## Getting started on a new machine

```sh
curl -Ls https://raw.github.com/gmolveau/dotfiles/main/bin/dotfiles-install.sh | bash
```

## How does it work ?

Using a shell alias `dotfiles` that specifies the git tracked folder, we can commit files and folders that are in `$HOME`.

- To start your own dotfiles tracking :

```sh
# init the repo
git init --bare ${HOME}/.dotfiles
# ignore everything to avoid accidentally committing things
echo "*" >> ${HOME}/.dotfiles/info/exclude
# add the following alias to `.bashrc` or `.zshrc`
alias dotfiles='/usr/bin/git --git-dir=${HOME}/.dotfiles/ --work-tree=${HOME}'
# configure the repo to not show untracked files
dotfiles config --local status.showUntrackedFiles no
# add the git remote
dotfiles remote add origin <your_git_url>
# add the files (`-f` to force add as we exclude everything)
dotfiles add -f .zshrc
dotfiles commit -m "add zshrc"
dotfiles push -u origin master
```
