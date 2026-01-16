#!/bin/bash

SOURCE=$(dirname $(readlink -f ${BASH_SOURCE}))
for config_dir in $(find $SOURCE/config -mindepth 1 -maxdepth 1 -type d -not -name "*.git" -not -name "*.mypy_cache*") ; do
    config_dir=$(basename $config_dir)
    cp -r ~/.config/${config_dir}/ ./config
done
for local_dir in $(find $SOURCE/local_share -mindepth 1 -maxdepth 1 -type d -not -name "*.git" -not -name "*.mypy_cache*") ; do
    local_dir=$(basename $local_dir)
    cp -r ~/.local/share/${local_dir}/ ./local_share
done


cp ~/.vim/vimrc  ~/.bashrc ./
