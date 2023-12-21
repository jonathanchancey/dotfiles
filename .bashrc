# .bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1='[\u@\h \W]\$ '

source ~/.env
source ~/.aliases

# restore and checkout a file from remote
# you'll run this 10+ times
rescheck() {
  config restore --staged "$@"
  config checkout --theirs "$@"
}

# functions
cpr() {
  rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 "$@"
} 
mvr() {
  rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files "$@"
}
