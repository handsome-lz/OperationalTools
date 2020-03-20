#!/bin/bash
#author: liuzhe
newrm () {
if [ -d ~/.copyOnDelete ]
then
	":"
else
	mkdir ~/.copyOnDelete
fi
if [ "$#" -gt 0 ]
then
	for file in "$@"
	do
		filename=$(echo "$file" | sed 's!.*/!!')
		if [ -f "$file" ]
		then
			mv "$file" ~/.copyOnDelete/$(date +%Y-%m-%d-%H-%M-%S-${filename}) && chmod 700 ~/.copyOnDelete/$(date +%Y-%m-%d-%H-%M-%S-${filename})
		fi
	done
		
		
else
	return 1
fi


}
newrm "$@"
