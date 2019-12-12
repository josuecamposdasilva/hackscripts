#!/bin/bash

# Make a temp file "templinks".

touch templinks

# Get latest posts' URLs and save to "links" var.
# Diff each URL's from var to "templinks" file
# adding the unmatched to file.
# Loop forever this process in background,
# sleeping 10s between each.

while true ; do

links="$( curl -s "https://pastebin.com/archive" | grep "i_p0" | cut -d"=" -f5 | cut -d'"' -f2 | tr -d "/" )"

	for l in $links ; do
		r="$( grep "$l" templinks )"
		if [ "$r" == "" ] ; then
			echo $l >> templinks
		fi
	done

	sleep 10
done &

exit
