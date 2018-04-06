#!/bin/bash

# Script para quebra de hash

echo

# Verifica se o script foi iniciado sem argumento.
# Caso sim, mostra um mensagem de uso na saida e encerra o script.

if [ "$1" == "" ] ; then 
	echo 
	echo "Uso: $0 wordlist.txt" 
	exit 
fi 

echo

# Converte o arquivo para o formato unix.
# Redireciona a saida para o vazio.

dos2unix $1 >> /dev/null

# Pega cada palavra do arquivo e encripta com uma hash especifica.
# Depois, escreve na saida cada palavra e a sua devida hash encriptada
# em cada linha.
# Redireciona o resultado para um arquivo.

for plvr in $( cat $1 ) ; do 
	md5="$( echo -n "$plvr" | md5sum | cut -d" " -f1 )"
	b64="$( echo -n "$plvr" | base64 )"
	sha256="$( echo -n "$plvr" | sha256sum | cut -d" " -f1 )"
	echo "$plvr:$md5:$b64:$sha256" 
done | column -s: -t >> "$1.final"

echo

exit
