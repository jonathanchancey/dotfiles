# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

KITTY_ENABLE_WAYLAND=1
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland-eg1

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
export TERM=linux
. "$HOME/.cargo/env"

export PATH="$PATH:/home/void/.local/bin"


alias xi="sudo xbps-install"
alias xq="xbps-query"

