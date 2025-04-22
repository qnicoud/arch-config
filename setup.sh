#!/bin/bash

SOURCE=$(dirname $(readlink -f ${BASH_SOURCE}))
for dir in $(find $SOURCE -mindepth 1 -maxdepth 1 -type d -not -name "*.git" ) ; do
    rm ${HOME}/.config/$(basename $dir)
    cp -r $dir "${HOME}/.config/"
    #ln -s $dir ~/.config/
done
