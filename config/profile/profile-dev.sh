#!/bin/bash

#=========================================================================================
# DEV related funtions

eval "$(uv generate-shell-completion bash)"  # For bash
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

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

# Check personnal git repos for unstaged or uncomitted modifications
function gitchk {
    
    if [ ! -z $1 ] && [[ $1 == "QUIET" ]]; then
        VERBOSE="False"
    else
        VERBOSE="True"
    fi
    
	[ $VERBOSE == "True" ] && echo

    if [ -f ~/.gitchk.ongoing ] ; then
        if find ~ -maxdepth 1 -name ".gitchk.ongoing" -cmin -10 | grep -q .gitchk.ongoing ; then
            [ $VERBOSE == "True" ] && echo -e "   ${GREEN}Local repo are already being checked elsewhere. ${RESTORE}"
            [ $VERBOSE == "True" ] && echo
            return
        else
            rm ~/.gitchk.ongoing 2>/dev/null
        fi
    fi

    if [ ! -f ~/.gitchk ] || find ~ -maxdepth 1 -name '.gitchk' -mmin +2 | grep -q .gitchk ; then 
    	CURR_DIR=$(pwd)
        rm ~/.gitchk 2> /dev/null
        touch ~/.gitchk.ongoing ~/.gitchk
	    FOUND="FALSE"
	    for repo in $(find ~ -type d -name ".git" ! -name "*.cache*" 2>/dev/null) ; do
		    builtin cd ${repo}/../
		    if git remote -v | grep -q qnicoud && [ ! -z "$(git status --porcelain)" ] ; then
			    #[ ! -z "$(git status --porcelain)" ] && echo -e "\t- $(dirname $repo)" && FOUND="TRUE"
                FOUND="TRUE" 
                echo $(dirname $repo) >> ~/.gitchk
		    fi
	    done
	    cd $CURR_DIR
        rm ~/.gitchk.ongoing
    elif [ -e ~/.gitchk ] && [ ! -s ~/.gitchk ]; then
        FOUND="FALSE"
    elif [ -e ~/.gitchk ] && [ -s ~/.gitchk ]; then
        FOUND="TRUE"
    fi

	[ $VERBOSE == "True" ] && echo -e "   ${GREEN}Local repo with changes to commit/push: ${RESTORE}"
    if [ $FOUND == "TRUE" ] ; then
        for repo in $(cat ~/.gitchk) ; do
            [ $VERBOSE == "True" ] && printf '\t- \e]8;;$(dirname $repo)\e\\'$(basename $repo)'\e]8;;\e\\\n' 
        done
	elif [ $FOUND == "FALSE" ] && [ $VERBOSE == "True" ] ; then
  		echo -e "\t- Everything is clean!"
	fi
    [ $VERBOSE == "True" ] && echo
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

