fish_add_path $HOME/scripts/
fish_add_path $HOME/.local/private/scripts/
fish_add_path $HOME/.local/bin/
fish_add_path $HOME/go/bin/
fish_add_path $HOME/.krew/bin/

function cpr
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 $argv
end

function mvr
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files $argv
end

function se
    sops --encrypt --in-place $argv
end

function sd
    sops --decrypt --in-place $argv
end

function fish_greeting
    # if ufetch is a known command, run it
    type -q ufetch; and ufetch
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

if status is-interactive

    # source files
    source ~/.env
    source ~/.aliases
    source ~/.local/private/env
    source ~/.local/private/.aliases

    # alias lsd to ls if it exists
    type -q lsd; and alias ls='lsd'

    # bodge to prevent shell from hanging with stale smb mounts
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
    set -gx HOMEBREW_REPOSITORY /opt/homebrew
    fish_add_path --prepend /opt/homebrew/bin /opt/homebrew/sbin
    set -gx MANPATH /opt/homebrew/share/man $MANPATH
    set -gx INFOPATH /opt/homebrew/share/info $INFOPATH

    set pure_check_for_new_release false
    set pure_enable_single_line_prompt false
    set MANPAGER 'nvim +Man!'

    # fzf --fish | source
    # tv init fish | source
    # kubectl completion fish | source
    # zoxide init fish | source

    # elegant reimplementation of sudo !!
    function last_history_item
        echo $history[1]
    end
    abbr -a !! --position anywhere --function last_history_item

    # add kubectl aliases if they exist
    test -f ~/.config/kubectl_aliases.fish && source ~/.config/kubectl_aliases.fish

    if test "$WORKMODE" = true
        set pure_enable_k8s false
    end
end
