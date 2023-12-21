
source $HOME/.env                                                                                                
source $HOME/.aliases

fish_add_path $HOME/scripts/
 
function cpr                                                                                                        
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 $argv                                   
end                                                                                                                 
                                                                                                                      
function mvr                                                                                                        
    rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files $argv             
end 

function fish_greeting
    ufetch
end
