#!/bin/bash

# Map 21, 22 and 80 ports of all localhosts.
# Give return to a variable.

mapl="$( nmap -sN -p 21,22,80 $( echo "$( ifconfig | grep "inet" | grep "broadcast" | cut -d" " -f10 | cut -d"." -f1-3 ).0/24" ) )"

# For every active IP in the network, show his open ports and OS.

for ip in $( echo "$mapl" | grep "report for" | cut -d" " -f5 ) ; do
	nmap -sS -F -O $ip > temp

	prts="$( cat temp | grep "/tcp" | cut -d"/" -f1 | tr "\n" " " )"
	if [ "$prts" == "" ] ; then prts="Closed!" ; fi

	os="$( cat temp | grep "OS details" | cut -d":" -f2 | cut -d" " -f2-99 | cut -d"," -f1 | grep -v  "many fingerprints" )"
	if [ "$os" == "" ] ; then os="Undefined!" ; fi

	echo "Active IP: $ip | Ports: $prts | OS: $os"

	rm ./temp
done

echo

exit
