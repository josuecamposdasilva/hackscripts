#!/bin/bash

# For use with "monit_pastebin.sh" script.

# Exits if have no arguments.

if [ "$1" == "" ] ; then
	echo
	echo "Usage: $0 text"
	echo
	exit
fi

# Read "templinks" file and give the value to "templ" var.

templ="$( cat templinks )"

# Looping "templ" var, outputing URLs that have the "text" argument.

for a in $( echo $templ ) ; do
	r2="$( curl -s https://pastebin.com/raw/$a | grep "$1" )"
	if [ "$r2" != "" ] ; then
		echo "https://pastebin.com/raw/$a"
	fi
done

exit
