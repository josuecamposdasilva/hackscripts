#!/bin/bash

# Exit if have no arguments.

if [ "$1" == "" ] ; then
	echo
	echo "Usage: $0 text n_search"
	echo
	echo "text: word or phrase (between double quotes)"
	echo "to be used as a filter."
	echo
	echo "n_search: times to perform the search"
	echo
	exit
fi

phrase="$( echo "$2" | grep "[a-zA-Z]" )"

if [[ "$2" == "" || "$frase" != "" ]] ; then
	echo
	echo "Usage: $0 text n_search"
	echo
	echo "text: word or phrase (between double quotes)"
	echo "to be used as a filter."
	echo
	echo "n_search: times to perform the search"
	echo
	exit
fi

# Make "templinks" and "templinks_use" temp files.

touch templinks templinks_use

# Make dirs to store files

mkdir -p $HOME/.pastebin/$(date --iso-8601)/$1/

# Get latest posts' URLs and save to "links" var.
# Diff each URL's from var to "templinks" file adding the unmatched to file.
# Loop this process "n_search" times, sleeping 5s between each.

meter=0 # Init the counter

while [ $meter -lt $2 ] ; do

	links="$( curl -s "https://pastebin.com/archive" | grep "i_p0" | cut -d"=" -f5 | cut -d'"' -f2 | tr -d "/" )"

	for l in $links ; do
		r="$( grep "$l" templinks )"
		if [ "$r" == "" ] ; then
			echo "$l" >> templinks
		fi
	done

# Assign the diff between "templinks" and "templinks_use" to "templ" var.

templ="$( diff templinks templinks_use | cut -d" " -f2 | grep "$( cat templinks )" )"

# Output URLs that match "text" in each loop from "templ" var
# Save file with the content from this URLs.

	for a in $( echo "$templ" ) ; do
		r2="$( curl -s https://pastebin.com/raw/$a | grep "$1" )"
		if [ "$r2" != "" ] ; then
			echo "https://pastebin.com/raw/$a"
			echo "$(curl -s https://pastebin.com/raw/$a)" >> $HOME/.pastebin/$(date --iso-8601)/$1/$a
		fi
	done

	echo "$templ" | tr " " "\n" >> templinks_use

	meter=$(( $meter + 1 ))

	sleep 5

done

rm templinks templinks_use

exit
