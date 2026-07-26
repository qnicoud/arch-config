#!/bin/bash

__venv_ps1 ()
{
    printf_format="$1"

    CURR_PWD=$(pwd)

    if ! [ -z "${VIRTUAL_ENV_PROMPT}" ] ; then
        venv_string=$(echo "${VIRTUAL_ENV_PROMPT}" | sed -E 's/\)|\(//g')
        printf -- "$printf_format" "$venv_string"
    fi
}
