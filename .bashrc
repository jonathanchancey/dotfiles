# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

source ~/.env
source ~/.aliases

alias config='/usr/bin/git --git-dir=$HOME/git/.dotfiles --work-tree=$HOME'

# restore and checkout a file from remote
# you'll run this 10+ times
rescheck() {
  config restore --staged "$@"
  config checkout --theirs "$@"
}
