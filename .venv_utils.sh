#!/bin/bash

venv() {
	local RED='\e[31m'
	local GREEN='\e[32m'
	local NC='\e[0m'
	local GIVEATRY="${GREEN}venv help ${NC}"

	if ([ $# -eq 0 ] || ([ $# -eq 1 ] && [ $1 == "help" ])) ; then
		echo -e "\tinit    - call venv molude to create virtual environment as .venv"
		echo -e "\tinstall - install libs from requirements.txt"
		echo -e "\tsave    - save requirements to requirements.txt"
		echo -e "\tin      - load virtual environment from [ .venv || venv ]"
		echo -e "\tout     - deactivate virtual environment"
		echo -e "\thelp    - venv function description"
	elif ([ $# -eq 1 ] && [ $1 == "init" ]) ; then
		python -m venv .venv
	elif ([ $# -eq 1 ] && [ $1 == "save" ]) ; then
		pip freeze > requirements.txt
	elif ([ $# -eq 1 ] && [ $1 == "install" ]) ; then
		local _F='requirements.txt'
		local FILE="`pwd`/${_F}"
		if [ -f "$FILE" ]; then
			pip install -r requirements.txt
		else 
			echo -e "${_F} ${RED}does not exist.${NC}" > /dev/stderr
		fi
	elif ([ $# -eq 1 ] && [ $1 == "in" ]) ; then
		local _D='venv'
		local _DD='.venv'
		local DIR1="`pwd`/${_D}"
		local DIR2="`pwd`/${_DD}"
		if [ -d "$DIR1" ]; then
			echo -e "found ${GREEN}${_D} ${NC} > activate" > /dev/stderr
			source "${DIR1}/bin/activate"
		elif [ -d "$DIR2" ]; then
			echo -e "found ${GREEN}${_DD} ${NC} > activate" > /dev/stderr
			source "${DIR2}/bin/activate"
		else
			echo -e "venv ${RED}does not exist.${NC}" > /dev/stderr
		fi
	elif ([ $# -eq 1 ] && [ $1 == "out" ]) ; then
		deactivate
	else
		echo -e "${RED}venv $1 command not exist${NC} try: ${GIVEATRY}" > /dev/stderr
	fi
}
