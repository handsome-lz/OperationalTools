#!/bin/bash
#author: liuzhe

validAlphaNum () {
if [ -n "$1" ]
then
	validparam=$(echo "$1" | sed 's/[0-9,a-z,A-Z]*//')
	if [ -n "$validparam" ]
	then
		echo "param ${1} is not valid"
		return 1
	else
		echo "params is valid"
		return 0
	fi
else
	echo need params!
	return 1
fi
}

read -p "please input your param:" -t 10 input
validAlphaNum "$input"
