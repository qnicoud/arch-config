#!/bin/bash

#=======================================================================================================
# Quality of life aliases and functions

# Coloring for base commands
alias ls="ls --color=auto --hyperlink=auto"
alias grep="grep --color=auto"

# Fix QT not launching under hyprland
alias freecad="QT_QPA_PLATFORM=xcb freecad 2&>1 >/dev/null &"
alias openrgb="QT_QPA_PLATFORM=xcb openrgb"
alias tor="QT_QPA_PLATFORM=xcb torbrowser-launcher &"

# Shortcuts for bashrc sourcing and editing
alias brcs="source /home/quentin/.config/profile/bashrc 'quiet'"
alias brce="nv /home/quentin/.config/profile/bashrc"
alias brc="brce && brcs"

# Aliasses for editors and frequently used commands
alias v="vim"
alias nv="nvim"
alias hypr="cd ~/.config/hypr && nv hyprland.lua && cd -"
alias home="cd && clear && fastfetch"


#=======================================================================================================
# functions


# Function to open multiple terminals at once
function kk { 
    nb=$1 
    tot=0
    re='^[0-9]+$'
    kitty_cmd="kitty --detach --hold -d $PWD"
    if [ $# != 1 ] ; then
        $kitty_cmd
        tot=1
    elif [[ $nb =~ $re ]] ; then 
        while [ $nb -gt 0 ] ; do 
            $kitty_cmd
            nb=$((nb - 1))
            tot=$((tot+1))
        done 
    fi                                                                                                                                                                                                                                                                
    if [ $tot -eq 1 ] ; then
        terms="terminal"
    elif [ $tot -gt 1 ] ; then
        terms="terminals"
    else
        return
    fi
    echo -e "\n   ${BLUE}${tot} ${terms} should have popped. :)${RESTORE}"
}

# Allow to execute script under specific conditions upon entering a folder
function exec_proc {
    if [ ! -f ${PWD}/.script ] ; then
        return 0
    fi

    proc="$(cat ${PWD}/.script)"
    if [ ! -f $proc ] ; then
        echo -e "\t${LYELLOW}/!\\ WARNING: Script file $proc does not seem to exits /!\\${RESTORE}"
        return 1
    elif $(ls $PWD | grep -q $proc) ; then 
        proc="./${proc}"
    fi

    perm=$(stat -c %a $PWD/.script)
    owner=$(stat -c %U $PWD/.script)
    if [ $perm != 700 ] || [ $owner != $(whoami) ] ; then
        echo -e "\t${LYELLOW}/!\\ WARNING: Will not execute proc $(cat ${PWD}/.script), .script file permissions or owner are dubious /!\\ ${RESTORE}"
        return 1
    fi

    proc_owner=$(stat -c %U $proc)
    if [ ! -x $proc ] || [ $proc_owner != $(whoami) ] ; then
        echo -e "\t${LYELLOW}/!\\ WARNING: Will not execute proc $(cat ${PWD}/.script), wrong permissions or owner /!\\ ${RESTORE}"
        return 1
    fi
    
    $proc
    
}


function cd { 
    builtin cd "$@" && 
    load_venv &&
    exec_proc
}

