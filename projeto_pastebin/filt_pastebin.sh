#!/bin/bash

# Script para filtrar os dados adquiridos pelo script "monit_pastebin.sh".

# Verifica se foi passado algum argumento.
# Se nao, mostra uma mensagem de uso na saida padrao e encerra o script.

if [ "$1" == "" ] ; then 
	echo
	echo "Uso: $0 texto_filtro"
	echo
	exit
fi

# Le o arquivo "templinks" e coloca o resultado na variavel "templ".

templ="$( cat templinks )"

# Le os argumentos da variavel "templ" e os coloca em loop.
# Mostra na saida padrao as URL's que contem o 'texto_filtro'.

for a in $( echo $templ ) ; do
	r2="$( curl -s https://pastebin.com/raw/$a | grep "$1" )"
	if [ "$r2" != "" ] ; then
		echo "https://pastebin.com/raw/$a"
	fi
done

exit
