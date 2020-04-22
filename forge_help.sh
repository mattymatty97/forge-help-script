#!/bin/bash

if [[ "$(uname -s)" == "Linux" ]]; then
    mc_folder=~/.minecraft
    use_tree=true
else
    mc_folder=~/Library/Application\ Support/minecraft
    use_tree=false
fi


if [ "$1" == "logs" ] || [ "$1" == "log" ]; then
	if [[ -d "$mc_folder/logs" ]]; then
		if [[ -f "$mc_folder/logs/latest.log" ]]; then
			out=$(curl -X POST https://hastebin.com/documents -T "$mc_folder/logs/latest.log")
			echo
			echo $out
			echo Send this Line to the support
			echo
		else
			echo Missing latest.log File
		fi
	else
		echo Missing minecraft folder
	fi
elif [ "$1" == "mods" ] || [ "$1" == "mod" ]; then
	if [[ -d "$mc_folder/mods" ]]; then
        if [[ $use_tree == true ]]; then
            which tree > /dev/null
		    if [[ $? -ne 0 ]]; then
		    	echo missing tree Please Install
		    	sudo apt install tree
		    fi
		    out=$(tree "$mc_folder/mods")
        else
		    out=$(find "$mc_folder/mods")
        fi
		out=$(curl -X POST https://hastebin.com/documents -d "$out")
		echo
		echo $out
		echo Send this Line to the support 
        echo
	else
		echo Missing mods Folder
	fi
fi
