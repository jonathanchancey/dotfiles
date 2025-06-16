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

# create a new branch with context
function cnb
    set branch (git branch --show-current)
    set domain_user jchancey
    set branch_name $argv[1]-$domain_user-$branch
    echo $branch_name
    git checkout -b $branch_name
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
    source ~/.local/private/.aliases

    # alias lsd to ls if it exists
    type -q lsd; and alias ls='lsd'

    eval "$(/opt/homebrew/bin/brew shellenv)"
    set pure_check_for_new_release false
    set pure_enable_single_line_prompt false
    set pure_enable_k8s true

    # function fish_user_key_bindings
    #     # Execute this once per mode that emacs bindings should be used in
    #     fish_default_key_bindings -M insert
    #
    #     # Then execute the vi-bindings so they take precedence when there's a conflict.
    #     # Without --no-erase fish_vi_key_bindings will default to
    #     # resetting all bindings.
    #     # The argument specifies the initial mode (insert, "default" or visual).
    #     fish_vi_key_bindings --no-erase insert
    # end

    # kubectl completion fish | source
    zoxide init fish | source

    set MANPAGER 'nvim +Man!'

    function last_history_item
        echo $history[1]
    end
    abbr -a !! --position anywhere --function last_history_item

    # add kubectl aliases if they exist
    test -f ~/.config/kubectl_aliases.fish && source ~/.config/kubectl_aliases.fish
end
