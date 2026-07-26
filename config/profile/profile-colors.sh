#!/bin/bash

#~/.config/matugen/templates/hyprland-colors.conf'=====================================================================================================g
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
