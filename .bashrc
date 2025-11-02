#======================================================================================================
# Setup color variables :
RESTORE='\033[0m'

RED='\033[00;31m'
GREEN='\033[00;32m'
YELLOW='\033[00;33m'
BLUE='\033[00;34m'
PURPLE='\033[00;35m'
CYAN='\033[00;36m'
LIGHTGRAY='\033[00;37m'

LRED='\033[01;31m'
LGREEN='\033[01;32m'
LYELLOW='\033[01;33m'
LBLUE='\033[01;34m'
LPURPLE='\033[01;35m'
LCYAN='\033[01;36m'
WHITE='\033[01;37m'

ITALIC='\e[3m'
NOITALIC='\e[23m'

#======================================================================================================
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/quentin/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/quentin/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/quentin/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/quentin/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
# To remove an error in conda
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

function load_conda_env {
    if [ -f $PWD/.conda_config ]; then
        export CONDACONFIGDIR=$PWD
        if [ -f ./.conda_config ] && ! conda env list | grep $(cat ./.conda_config) ; then 
            conda create -yqn $(cat ./.conda_config)
        fi
        conda activate $(cat ./.conda_config)
    elif [ "$CONDACONFIGDIR" ]; then
        if [[ $PWD != *"$CONDACONFIGDIR"* ]]; then
            unset CONDACONFIGDIR
            conda activate "base"
        fi
    else
        conda activate "base"
    fi 
}
load_conda_env


#======================================================================================================
# Define prompt
omp_theme="multiverse-neon.omp.json"
eval "$(~/.local/bin/oh-my-posh init bash --config ~/.local/bin/${omp_theme})"
alias hyprland="hyprland > hyprland.logs 2>&1 &"

#=======================================================================================================
# Quality of life aliases and functions
alias ls="ls --color=auto --hyperlink=auto"
alias grep="grep --color=auto"
alias v="vim"
alias nv="nvim"
alias hyprconf="vim /home/quentin/.config/hypr/hyprland.conf"
alias freecad="QT_QPA_PLATFORM=xcb freecad 2&>1 >/dev/null &"
alias openrgb="QT_QPA_PLATFORM=xcb openrgb &"
alias tor="QT_QPA_PLATFORM=xcb torbrowser-launcher &"
alias brcs="source /home/quentin/.bashrc 'quiet'"
alias brce="vim /home/quentin/.bashrc"
alias brc="brce && brcs"
alias hypr="vim ~/.config/hypr/hyprland.conf"

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
    load_conda_env &&
    exec_proc
}

function cdp {
    echo -e "\n  ${GREEN}List of personnal gits:${RESTORE}"
    list_gits=($(ls -d ~/bin/git-repos-personal/*))
    CNT=0
    for git_folder in ${list_gits[@]} ; do
        CNT=$((CNT+1))
        echo -e "${ITALIC} \t${CNT} - $(basename $git_folder)${NOITALIC}"
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

function gitchk {
	CURR_DIR=$(pwd)
	echo
	echo -e "   ${GREEN}Local repo with changes to commit/push: ${RESTORE}"
	FOUND="FALSE"
	for repo in $(find ~ -type d -name ".git" 2>/dev/null) ; do
		builtin cd ${repo}/../
		if git remote -v | grep -q qnicoud ; then
			#[ ! -z "$(git status --porcelain)" ] && echo -e "\t- $(dirname $repo)" && FOUND="TRUE"
            [ ! -z "$(git status --porcelain)" ] && printf '\t- \e]8;;$(dirname $repo)\e\\'$(basename $(dirname $repo))'\e]8;;\e\\\n' && FOUND="TRUE" 
		fi
	done
	if [ $FOUND == "FALSE" ] ; then
  		echo -e "\t- Everything is clean!"
	fi
	cd $CURR_DIR
}
#export -f gitchk
if [ "$1" != "quiet" ] ; then
    fastfetch
    gitchk
fi

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

function cura {
    declare -a file_list=()
    if [ $# == 0 ] ; then
        for file in $(ls *.STL *.stl 2>/dev/null) ; do
            file_list+=($(realpath $file))
        done
    else
        for file in $(ls "$@") ; do
            file_list+=($(realpath $file))
        done
    fi

    echo -e "\n   ${BLUE}Trying to open ${#file_list[@]} STL files in cura:${RESTORE}"
    for file in ${file_list[@]} ; do
        echo -e "\t- $(basename $file)"
    done
    echo

    /usr/bin/cura "${file_list[@]}" >/dev/null 2>&1 &
}

function thingy {
    echo
    model_source="/home/quentin/Archives/3D_models/"
    if ! [ -f "$@" ] || ! unzip -qt "$@" >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Provided parameter is not a file or not a zip.${RESTORE}" 
        return 1
    fi
   
    ZIP_OK="TRUE"
    for item in "images/" "files/" "README" "LICENSE" ; do
        if ! unzip -l "$@" | grep -q $item >/dev/null 2>&1 ; then
            ZIP_OK="FALSE"
            break
        fi
    done

    if [ $ZIP_OK != "TRUE" ] ; then
        echo -e "\t${YELLOW}/!\ WARNING: file does not seem to come from thingyverse. Please check manually.${RESTORE}"
        return 1 
    fi
    
    echo -e "   ${GREEN}Please choose a folder to store the downloaded STL in:${RESTORE}"
    increment=0
    mapfile -d $'\0' folder_list < <(find $model_source -maxdepth 1 -mindepth 1 -type d -print0)    
    for folder in ${folder_list[@]} ; do
        increment=$((increment+1))
        echo -e "\t${increment} - $(basename ${folder})"
    done
    echo
    input=0
    while [ $input -lt 1 ] || [ $input -gt $increment ] ; do
        echo -n " Select a number between 1 and ${increment}: "
        read -n1 input
    done
    echo -e "\n\n ${BLUE}You chose ${folder_list[$((input-1))]}${RESTORE}\n"
    echo -ne " Please choose a name for the new folder: "
    read folder_name
    echo -e "\n ${BLUE}You chose ${folder_name}${RESTORE}\n"

    dest="${folder_list[$((input-1))]}/${folder_name}/" 
    if ! mkdir -p $dest >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Failed to create ${folder_name} in ${model_source}${RESTORE}"
        return 1
    else
        echo -e "\t-> Created ${folder_name} in ${model_source}."
    fi

    if ! mv "$@" "$dest" >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Failed to move ${@} in ${dest}${RESTORE}"
        return 1
    else
        echo -e "\t-> Moved ${@} in ${dest}."
    fi

    cd $dest
    if ! unzip "$@" >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Failed to unzip ${@}${RESTORE}"
        cd -
        return 1
    else
        echo -e "\t-> Unzipped ${@}."
    fi

    if ! mv ${dest}/files/* ${dest} >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Failed to move STL files in ${dest}${RESTORE}"
        cd -
        return 1
    else
        echo -e "\t-> Moved STL files in ${dest}."
    fi

    if ! rm -rf "$@" files images LICENSE.txt README.txt >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Failed to clean licence, readme, images, files folder or any combination of those.${RESTORE}"
        cd -
        return 1
    else
        echo -e "\t-> Purged unwanted files ${@}."
    fi

    echo -e "\n ${BLUE}You are now in ${dest}. STL files preparation is done.${RESTORE}\n"

}

#======================================================================================================
# Configuration of kubernetes functionalities
export KUBE_EDITOR="vim"
source /usr/share/bash-completion/bash_completion
source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k
alias manifests="cd /mnt/shared_drive_pi/manifests/"

#======================================================================================================
# Configuration of GenAI functionnalities
llama_start () {
	if [ -f /home/quentin/.llama.pid ] ; then
		echo "Llama server is already running..."
		return 1
	fi
# source /home/quentin/Bin/ext_bin_repo/llama.cpp/llama/bin/activate  # commented out by conda initialize
	cd /home/quentin/Bin/ext_bin_repo/llama.cpp/build/bin/
	nohup ./llama-server -m ../../../Mistral-7B-Instruct-v0.2/Mistral-7B-Instruct-v0.2-F16.gguf -c 2048 >> /tmp/llama.log &
	cd - && cd
	echo $! > .llama.pid
	deactivate
	cd -
}

llama_stop () {
	cd
	kill $(cat .llama.pid)
	rm .llama.pid
	cd -
}

#======================================================================================================
# History configuration
export HISTTIMEFORMAT='%d/%m/%y - %T -> '
export HISTCONTROL="ignoreboth"
export HISTIGNORE="clear:history:[bf]g:exit:date:* --help"
export HISTSIZE=2000
export HISTFILESIZE=5000
#export PROMPT_COMMAND='history -a' #Not working with oh my posh

#PSI configuration
#source ~/bin/shell-scripts/git-prompt.sh
#PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " 📑(%s)")'; PS1='\n\[\e[2m\]┌─ \[\e[0;38;5;202;1m\]\u\[\e[39m\]@\[\e[38;5;33m\]\h\[\e[0m\] 📁\[\e[38;5;255m\]\W\[\e[0m\] ${PS1_CMD1}\n\[\e[2m\]└─────\[\e[1m\]$?\[\e[0m\] \[\e[1m\]\$\[\e[0m\] '

### Color test function {{{
function color_test {
  #   Daniel Crisman's ANSI color chart script from
  #   The Bash Prompt HOWTO: 6.1. Colours
  #   http://www.tldp.org/HOWTO/Bash-Prompt-HOWTO/x329.html
  #
  #   This function echoes a bunch of color codes to the
  #   terminal to demonstrate what's available.  Each
  #   line is the color code of one forground color,
  #   out of 17 (default + 16 escapes), followed by a
  #   test use of that color on all nine background
  #   colors (default + 8 escapes).
  #

  T='gYw'   # The test text

  echo -e "\n         def     40m     41m     42m     43m     44m     45m     46m     47m";

  for FGs in '    m' '   1m' '  30m' '1;30m' '  31m' '1;31m' '  32m' \
             '1;32m' '  33m' '1;33m' '  34m' '1;34m' '  35m' '1;35m' \
             '  36m' '1;36m' '  37m' '1;37m';

    do FG=${FGs// /}
    echo -en " $FGs \033[$FG  $T  "

    for BG in 40m 41m 42m 43m 44m 45m 46m 47m;
      do echo -en "$EINS \033[$FG\033[$BG  $T  \033[0m";
    done
    echo;
  done
  echo


  echo -e "\e[1mBold\e[0m"
  echo -e "\e[3mItalic\e[0m"
  echo -e "\e[4mUnderline\e[0m"
  echo -e "\e[8mConceal\e[0m"
  echo -e "\e[9mCrossed-out\e[0m"
}



. "$HOME/.local/share//../bin/env"
export PATH=${PATH}:~/.config/emacs/bin

