#!/bin/bash

#=========================================================================================
# DEV related funtions

eval "$(uv generate-shell-completion bash)"  # For bash
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
export FZF_DEFAULT_OPTS="--style=full --height=40%"

#======================================================================================================
# Configuration of kubernetes functionalities
export KUBE_EDITOR="nvim"
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
alias k=kubectl
alias kn=kubens
alias kx=kubectx
complete -o default -F __start_kubectl k
alias manifests="cd /mnt/shared_drive_pi/manifests/"

# Load venv in curr folder
function load_venv {
    if [ -d ${PWD}/.venv ]; then
        VENV_PROJECT_DIR="${PWD}"
        source .venv/bin/activate
    fi

    if ! [ -z "${VENV_PROJECT_DIR}" ] && [[ $(type -t deactivate) == function ]] ; then
        echo "${PWD}" | grep -q "${VENV_PROJECT_DIR}" || deactivate
    fi
}

# Change curr dir for dev repo dir
function cdp {
    list_gits=($(ls -d ~/bin/git-repos-personal/*))

    if [ ! -z $1 ] && [[ " ${list_gits[*]} " =~ "/${1} " ]] ; then
        cd ~/bin/git-repos-personal/${1}
        return
    fi
    
    echo -e "\n  ${GREEN}List of personnal gits:${RESTORE}"
    CNT=0
    for git_folder in ${list_gits[@]} ; do
        CNT=$((CNT+1))
        if grep -q "${git_folder}" ~/.gitchk 2> /dev/null ; then
            PREFIX="${RED}"
            SUFFIX=" (changes to stage/commit/push)${RESTORE}"
        else
            PREFIX=""
            SUFFIX=""
        fi
        echo -e "${ITALIC}${PREFIX} \t${CNT} - $(basename $git_folder)${SUFFIX}${NOITALIC}"

    done

    answer=""
    echo
    while true; do
        read -p " Which repo to go to (q to quit): " answer
        if [[ $answer =~ ^[[:digit:]]+$ ]] ; then
            if [ $answer -ge 1 ] && [ $answer -le $CNT ]; then
                break
            else
                echo -e "${ITALIC} \tPlease enter a number between 1 and ${CNT} (or q)${NOITALIC}"
            fi
        elif [[ $answer == "q" ]] ; then
            return
        else
            echo -e "${ITALIC} \tPlease enter a number between 1 and ${CNT} (or q)${NOITALIC}"
        fi
    done
    echo -e "\n ${BLUE}Switching to ${list_gits[$((answer-1))]}${RESTORE}"
    cd ${list_gits[$((answer-1))]}
}


# Start or stop jupyterlab -- deprecated TODO: correct fucntion to start jupyterlab via uv
function jupyterlab_switch {
    if ! systemctl --user is-active --quiet jupyterlab.service ; then
        echo -e "\n   ${BLUE}Starting juptyter lab ...${RESTORE}"
        systemctl --user start jupyterlab.service
        echo -e "\tDone!"
    else
        echo -e "\n    ${BLUE}Stopping jupyter lab ...${RESTORE}"
        systemctl --user stop jupyterlab.service
        echo -e "\tDone!"
    fi
}
alias jls=jupyterlab_switch

