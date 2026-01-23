#!/usr/bin/bash

function getWaybarProcesses() {
    waybarProcessList=($(pgrep waybar))
    nbProcess=${#waybarProcessList[@]}
}

getWaybarProcesses

if [[ $nbProcess -eq 0 ]]; then
    waybar > /var/log/waybar/waybar.log 2>&1
elif [[ $nbProcess -gt 1 ]]; then
    while [[ $nbProcess -ne 1 ]]; do
        kill ${waybarProcessList[-1]}
        getWaybarProcesses
    done
else
    kill ${waybarProcessList[-1]}
    waybar > /var/log/waybar/waybar.log 2>&1
fi
