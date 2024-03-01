fish_add_path $HOME/scripts/
 
function cpr
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 $argv                                   
end

function mvr
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files $argv             
end 

function fish_greeting
    # if ufetch is a known command, run it
    type -q ufetch; and ufetch
end

if status is-interactive

    # source files if they exist
    test -s ~/.env && source ~/.env || true
    test -s ~/.aliases && source ~/.aliases || true

    # alias lsd to ls if it exists
    type -q lsd; and alias ls='lsd'
    
    # add kubectl aliases if they exist
    test -f ~/.config/kubectl_aliases.fish && source ~/.config/kubectl_aliases.fish
end
