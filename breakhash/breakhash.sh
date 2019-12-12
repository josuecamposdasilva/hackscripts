#!/bin/bash

# If the script have no arguments,
# print a mesage error and exit

if [ "$1" == "" ] ; then
	echo
	echo "Use: $0 wordlist.txt"
	exit
fi

echo

# Convert the input file to unix type.
# Redirect the output to null.

dos2unix $1 >> /dev/null

# Encrypt with hashing every single word,
# Redirect the result to a file.

for word in $( cat $1 ) ; do
	md5="$( echo -n "$word" | md5sum | cut -d" " -f1 )"
	b64="$( echo -n "$word" | base64 )"
	sha256="$( echo -n "$word" | sha256sum | cut -d" " -f1 )"
	echo "$word:$md5:$b64:$sha256"
done | column -s: -t >> "$1.final"

echo

exit
