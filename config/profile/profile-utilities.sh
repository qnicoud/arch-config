#!/bin/bash

#====================================================================
# 3D printing  related functions

alias models="cd ~/Documents/3D_models/ && ls"

# Start cura with all files in cur folder or a subset via regex
function cura {
    declare -a file_list=()
    if [ $# == 0 ] ; then
        for file in $(ls *.STL *.stl 2>/dev/null) ; do
            file_list+=($(realpath $file))
        done
    else
        for file in $(ls "$@") ; do
            file_list+=($(realpath $file))
        done
    fi

    echo -e "\n   ${BLUE}Trying to open ${#file_list[@]} STL files in cura:${RESTORE}"
    for file in ${file_list[@]} ; do
        echo -e "\t- $(basename $file)"
    done
    echo

    /usr/bin/cura "${file_list[@]}" >/dev/null 2>&1 &
}

# automatically extract thigyverse archive and export it to the dedicated folder
function thingy {
    echo
    model_source="/home/quentin/Documents/3D_models/"
    if ! [ -f "$@" ] || ! unzip -qt "$@" >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Provided parameter is not a file or not a zip.${RESTORE}" 
        return 1
    fi
   
    ZIP_OK="TRUE"
    for item in "images/" "files/" "README" "LICENSE" ; do
        if ! unzip -l "$@" | grep -q $item >/dev/null 2>&1 ; then
            ZIP_OK="FALSE"
            break
        fi
    done

    if [ $ZIP_OK != "TRUE" ] ; then
        echo -e "\t${YELLOW}/!\ WARNING: file does not seem to come from thingyverse. Please check manually.${RESTORE}"
        return 1 
    fi
    
    echo -e "   ${GREEN}Please choose a folder to store the downloaded STL in:${RESTORE}"
    increment=0
    mapfile -d $'\0' folder_list < <(find $model_source -maxdepth 1 -mindepth 1 -type d -print0)    
    for folder in ${folder_list[@]} ; do
        increment=$((increment+1))
        echo -e "\t${increment} - $(basename ${folder})"
    done
    echo
    input=0
    while [ $input -lt 1 ] || [ $input -gt $increment ] ; do
        echo -n " Select a number between 1 and ${increment}: "
        read -n1 input
    done
    echo -e "\n\n ${BLUE}You chose ${folder_list[$((input-1))]}${RESTORE}\n"
    echo -ne " Please choose a name for the new folder: "
    read folder_name
    echo -e "\n ${BLUE}You chose ${folder_name}${RESTORE}\n"

    dest="${folder_list[$((input-1))]}/${folder_name}/" 
    if ! mkdir -p $dest >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Failed to create ${folder_name} in ${model_source}${RESTORE}"
        return 1
    else
        echo -e "\t-> Created ${folder_name} in ${model_source}."
    fi

    if ! mv "$@" "$dest" >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Failed to move ${@} in ${dest}${RESTORE}"
        return 1
    else
        echo -e "\t-> Moved ${@} in ${dest}."
    fi

    cd $dest
    if ! unzip "$@" >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Failed to unzip ${@}${RESTORE}"
        cd -
        return 1
    else
        echo -e "\t-> Unzipped ${@}."
    fi

    if ! mv ${dest}/files/* ${dest} >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Failed to move STL files in ${dest}${RESTORE}"
        cd -
        return 1
    else
        echo -e "\t-> Moved STL files in ${dest}."
    fi

    if ! rm -rf "$@" files images LICENSE.txt README.txt >/dev/null 2>&1 ; then
        echo -e "\t${RED}/!\ ERROR: Failed to clean licence, readme, images, files folder or any combination of those.${RESTORE}"
        cd -
        return 1
    else
        echo -e "\t-> Purged unwanted files ${@}."
    fi

    echo -e "\n ${BLUE}You are now in ${dest}. STL files preparation is done.${RESTORE}\n"

}

