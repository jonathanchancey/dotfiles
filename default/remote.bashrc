
# this bashrc file is to be used as a default addition to the remote machines


# every new ssh session uses tmux by default
[ -z "$TMUX"  ] && { tmux attach || exec tmux new-session && exit;}

