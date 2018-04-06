#!/bin/bash

# Script para adiqurir, filtrar e mostrar / guardar o conteudo das postagens 
# do pastebin.com.

# Cria o arquivo temporario 'templinks'.

touch templinks

# Adquire as URL's das postagens mais recentes.
# Salva o resultado em uma variavel.
# Verifica as URL's da variavel com as contidas no arquivo 'templinks' e 
# salva todas as que nao estao presentes no arquivo, ignorando as que ja 
# estao.
# Repete o processo interminavelmente, colocando um periodo de 10s entre
# eles.
# Coloca a execucao do script em plano de fundo.

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
