#!/bin/bash

# concatenate files with their hostname counterparts if they exist
# TODO doesn't check if base exists, should always exist
# we're playing with fire here, needs more checks
shortname="$(hostname -s)"
commandpath="${HOME}/.i3/config."
hostnamecpath="${commandpath}${shortname}"
if [ -f "$hostnamecpath" ]; then
    echo "$hostnamecpath exists"
	cat ~/.i3/config.base > ~/.i3/config
	cat $hostnamecpath >> ~/.i3/config
else 
    echo "$hostnamecpath does not exist"
fi


shortname="$(hostname -s)"
filepath="${HOME}/.bash_profile"
catpath1="${HOME}/.dotfiles/cat/.bash_profile.${shortname}"
catpath2="${HOME}/.dotfiles/cat/.bash_profile.base"

if [ -f "$catpath1" ]; then
    echo "$catpath1 exists"
	cat $catpath2 > $filepath
	cat $catpath1 >> $filepath
else 
    echo "$catpath1 does not exist"
fi