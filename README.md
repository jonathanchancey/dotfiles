# dotfiles
dots for my current systems

## Management 
https://news.ycombinator.com/item?id=11071754

https://www.atlassian.com/git/tutorials/dotfiles

## Adding a new system

```bash

mkdir $HOME/git

git clone --bare https://github.com/jonathanchancey/dotfiles $HOME/git/.dotfiles

alias config='/usr/bin/git --git-dir=$HOME/git/.dotfiles --work-tree=$HOME'

config status


config restore --staged file
config checkout --theirs file


rescheck() {
  config restore --staged "$@"
  config checkout --theirs "$@"
} 

config config --local status.showUntrackedFiles no


```