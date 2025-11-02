#!/bin/bash

SOURCE=$(dirname $(readlink -f ${BASH_SOURCE}))
for config_dir in $(find $SOURCE -mindepth 1 -maxdepth 1 -type d -not -name "*.git" -not -name "*.mypy_cache*") ; do
    config_dir=$(basename $config_dir)
    cp -r ~/.config/${config_dir}/ ./
done

cp ~/.vim/vimrc  ~/.bashrc ./
