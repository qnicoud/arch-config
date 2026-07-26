#!/bin/bash

#======================================================================================================
# ENV setup

# Define prompt
#omp_theme="multiverse-neon.omp.json"
#omp_theme="emodipt-extend_CUSTOM.omp.json"
#omp_theme="tokyonight_storm.omp.json"
#omp_theme="pure.omp.json"
#eval "$(~/.local/bin/oh-my-posh init bash --config ~/.local/bin/${omp_theme})"
#alias hyprland="hyprland > hyprland.logs 34;2m>&1 &"
source ~/.config/profile/prompt-git.sh
source ~/.config/profile/prompt-venv.sh
export GIT_PS1_SHOWUPSTREAM="verbose"
export GIT_PS1_SHOWDIRTYSTATE="True"
export GIT_PS1_SHOWCOLORHINTS="True"
export PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 "\e[34;2m ── \e[22m󰊢  %s") PS1_CMD2=$(__venv_ps1 "\e[34;2m ── \e[22m󰰫  %s")'; PS1='\n\[\e[34;2m\]╭──\[\e[22m\]  \w${PS1_CMD1}${PS1_CMD2}\[\e[34;2m\] ── \[\e[22m\]  \t\n\[\e[34;2m\]╰──\[\e[1m\]$?\[\e[0;34;2m\]─\[\e[22m\]❯ \[\e[0m\]'


# History configuration
export HISTTIMEFORMAT='%d/%m/%y - %T -> '
export HISTCONTROL="ignoreboth"
export HISTIGNORE="clear:history:[bf]g:exit:date:* --help"
export HISTSIZE=2000
export HISTFILESIZE=5000
#export PROMPT_COMMAND='history -a' #Not working with oh my posh

# Path and env variables
. "$HOME/.local/share/../bin/env"

# Add doom emacs to the path
export PATH=${PATH}:~/.config/emacs/bin

