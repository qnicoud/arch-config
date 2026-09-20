#!/bin/bash

source /home/quentin/.config/profile/profile-colors.sh

VERBOSE="True"
FORCE="False"
while getopts 'qf' OPTION; do
  case "$OPTION" in
    q)
      VERBOSE="False"
      ;;
    f)
      FORCE="True"
      ;;
    ?)
      echo "script usage: $(basename \$0) [-q] [-f] " >&2
      exit 1
      ;;
  esac
done

[ $VERBOSE == "True" ] && echo

if [ -f ~/.gitchk.ongoing ] && [ $FORCE != "True" ] ; then
    if find ~ -maxdepth 1 -name ".gitchk.ongoing" -cmin -10 | grep -q .gitchk.ongoing ; then
        [ $VERBOSE == "True" ] && echo -e "   ${GREEN}Local repo are already being checked elsewhere. ${RESTORE}"
        [ $VERBOSE == "True" ] && echo
        exit
    else
        rm ~/.gitchk.ongoing 2>/dev/null
    fi
fi

GITCHK_COND=$([ ! -f ~/.gitchk ] || find ~ -maxdepth 1 -name '.gitchk' -mmin +2 | grep -q .gitchk ; echo $?)
if [ $GITCHK_COND -eq 0 ] || [ $FORCE == "True" ] ; then 
	CURR_DIR=$(pwd)
    rm ~/.gitchk 2> /dev/null
    touch ~/.gitchk.ongoing ~/.gitchk
	    FOUND="FALSE"
	    for repo in $(find ~ -type d -name ".git" ! -name "*.cache*" ! -name "*.local*" 2>/dev/null) ; do
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
