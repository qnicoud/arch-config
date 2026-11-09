#!/usr/bin/env bash
export PATH=${PATH}:~/.config/emacs/bin 
if ! systemctl --user is-active --quiet emacs ; then
    systemctl --user restart emacs
fi

emacsclient -c
