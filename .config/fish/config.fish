if status is-interactive
    # Commands to run in interactive sessions can go here
end

source $HOME/.env
source $HOME/.aliases

# wal -Rq

fish_add_path $HOME/scripts/

# set -gx PATH $PATH $HOME/.krew/bin

# set -xg KUBECONFIG /home/coal/.kube/academy-config

# TODO make sure variables exists
#if test $XDG_SESSION_TYPE = wayland
#    source $HOME/.env_wayland
#end

# functions

function cpr
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 $argv
end

function mvr
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files $argv
end

# theme.sh
if type -q theme.sh
	if test -e ~/.theme_history
	theme.sh (theme.sh -l|tail -n1)
	end

	# Optional
	# Bind C-o to the last theme.
	function last_theme
		theme.sh (theme.sh -l|tail -n2|head -n1)
	end

	bind \co last_theme

	alias th='theme.sh -i'

	# Interactively load a light theme
	alias thl='theme.sh --light -i'

	# Interactively load a dark theme
	alias thd='theme.sh --dark -i'
end

fish_config theme choose "Rosé Pine Moon"

# jump
function __jump_add --on-variable PWD
  status --is-command-substitution; and return
  jump chdir
end

function __jump_hint
  set -l term (string replace -r '^j ' '' -- (commandline -cp))
  jump hint "$term"
end

function j
  set -l dir (jump cd "$argv")
  test -d "$dir"; and cd "$dir"
end

complete --command j --exclusive --arguments '(__jump_hint)'

# greeting
function fish_greeting
    ufetch
end

