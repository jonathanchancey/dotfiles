#!/bin/bash

apt-get update
apt-get install neovim ranger curl wget tmux net-tools btop -y

if [ -e "/etc/debian_version" ]; then
    curl https://gitlab.com/jschx/ufetch/-/raw/main/ufetch-debian > /usr/local/bin/ufetch
    chmod +x /usr/local/bin/ufetch
fi

update-alternatives --set editor /usr/bin/nvim

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# variables
export EDITOR="nvim"
export VISUAL="nvim"
export TZ='America/Los_Angeles'
export HARDWARECLOCK=localtime

export XCURSOR_THEME=Adwaita
export WLR_NO_HARDWARE_CURSORS=1

# aliases
# xbps quality of life 
alias xi="apt-get install"
alias xr="apt-get remove"
alias xq="apt-cache search"

# normal aliases
alias ls='ls --color=auto'
alias setmon=/home/coal/.local/bin/set-monitor.sh
alias vim=nvim
alias ranger=$HOME/apps/ranger/ranger.py

# kubernetes aliases
alias k='kubectl'
alias kg='kubectl get'
alias ka='kubectl apply -f'
alias kd='kubectl delete -f'
alias kak='kubectl apply -k'
alias kex='kubectl exec -i -t'
alias klon='kubectl logs -f'

# everyday quick editing and sourcing
alias sb="source $HOME/.bashrc && echo $HOME/.bashrc sourced"
alias eb="$EDITOR $HOME/.bashrc"
alias l='ls -lh'
alias la='ls -lah'
alias lah='ls -lah'
alias lan='ls -lanh'
alias rm="trash-put"

# functions
cpr() {
 rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
} 
mvr() {
 rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
}

clear

/usr/local/bin/ufetch
