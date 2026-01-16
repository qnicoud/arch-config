#!/bin/bash

SOURCE=$(dirname $(readlink -f ${BASH_SOURCE}))
for dir in $(find $SOURCE/config -mindepth 1 -maxdepth 1 -type d -not -name "*.git" ) ; do
    rm ${HOME}/.config/$(basename $dir)
    cp -r $dir "${HOME}/.config/"
    #ln -s $dir "${HOME}/.config/"
done
for dir in $(find $SOURCE/local_share -mindepth 1 -maxdepth 1 -type d -not -name "*.git" ) ; do
    rm ${HOME}/.local/share/$(basename $dir)
    cp -r $dir "${HOME}/.local/share/"
    #ln -s $dir "${HOME}/.config/"
done
