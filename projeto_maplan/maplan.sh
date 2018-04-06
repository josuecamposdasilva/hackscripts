#!/bin/bash

# Script para mapear a rede interna.

echo

# Mapeia portas 21, 22 e 80 de todos os hosts da rede.
# Coloca o resultado em uma variavel.

mapl="$( nmap -sN -p 21,22,80 $( echo "$( ifconfig | grep "inet" | grep "broadcast" | cut -d" " -f10 | cut -d"." -f1-3 ).0/24" ) )"

# Filtragem dos dados coletados.

# Filtra as portas e o sistema operacional dos IP's ativos na rede.

for ip in $( echo "$mapl" | grep "report for" | cut -d" " -f5 ) ; do
	nmap -sS -F -O $ip > temp

	prts="$( cat temp | grep "/tcp" | cut -d"/" -f1 | tr "\n" " " )"
	if [ "$prts" == "" ] ; then prts="Fechadas!" ; fi

	os="$( cat temp | grep "OS details" | cut -d":" -f2 | cut -d" " -f2-99 | cut -d"," -f1 | grep -v  "many fingerprints" )"
	if [ "$os" == "" ] ; then os="Indetectado!" ; fi

	echo "IP Ativo: $ip | Portas: $prts | Sistema Operacional: $os"

	rm ./temp
done

echo

exit
