fish_add_path $HOME/scripts/
fish_add_path $HOME/.local/private/scripts/
# set -xg KUBECONFIG /Users/ice/.kube/config:/Users/ice/git/stacks/ansible/coalesce/autogenerated/rke2-coalesce.yaml:/Users/ice/git/stacks/ansible/coalesce/autogenerated/rke2-dichotomy.yaml
eval "$(/opt/homebrew/bin/brew shellenv)"
kubectl completion fish | source
set pure_enable_single_line_prompt true

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


function fish_greeting
    # if ufetch is a known command, run it
    type -q ufetch; and ufetch
end

# draft idea to run xi with no arguments will install program if xq program was last run
# function xi
#     if test string split " " "$history[1]" = "xq"
#         brew install $history[1..3]
#     end
#     # if test "$history[1][2]" = "xq brew install"
#     #     brew install $history[1..3]
#     # end
# end

if status is-interactive

    # source files if they exist
    test -s ~/.env && source ~/.env || true
    test -s ~/.aliases && source ~/.aliases || true
    test -s ~/.local/private/.aliases && source ~/.local/private/.aliases  || true

    # alias lsd to ls if it exists
    type -q lsd; and alias ls='lsd'

    zoxide init fish | source
    direnv hook fish | source

    # add kubectl aliases if they exist
    test -f ~/.config/kubectl_aliases.fish && source ~/.config/kubectl_aliases.fish
end
