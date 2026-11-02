#!/bin/bash

function getSnappyProcesses() {
    snappyProcessList=($(pgrep waybar))
    nbProcess=${#snappyProcessList[@]}
}

getSnappyProcesses

if [[ $nbProcess -eq 0 ]]; then
    snappy-switcher --daemon
elif [[ $nbProcess -gt 1 ]]; then
    while [[ $nbProcess -ne 1 ]]; do
        kill ${snappyProcessList[-1]}
        getSnappyProcesses
    done
else
    kill ${snappyProcessList[-1]}
    snappy-switcher --daemon
fi
