# dotfiles
dots for my current systems

## Management 
https://news.ycombinator.com/item?id=11071754

https://www.atlassian.com/git/tutorials/dotfiles

## Adding a new system 

in this example you are me

start by creating a git folder and cloning a bare repo

```bash

mkdir $HOME/git

git clone --bare https://github.com/jonathanchancey/dotfiles $HOME/git/.dotfiles

```

add this to your `~/.bashrc`
```bash
alias config='/usr/bin/git --git-dir=$HOME/git/.dotfiles --work-tree=$HOME'

rescheck() {
  config restore --staged "$@"
  config checkout --theirs "$@"
} 
```

check `config status` after each command

reconcile differents by restoring remote files with `rescheck FILEPATH` 

stage and commit your changes with `config add FILENAME` `config commit -m "init commit"`

and create a new branch on remote with `config push -u origin user-host`

finish off with `config config --local status.showUntrackedFiles no`

and you should be all set 
